class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :build
  after_reflex :sum
  
  def urgence
    
    @urgence = Urgence.find(element[:value])
    @delivery.options << @urgence

    @delivery.pickups.first.end_hour = next_availible_delivery_time(@delivery, @city).strftime("%k:%M")
    @delivery.drops.first.end_hour = next_availible_delivery_time(@delivery, @city).strftime("%k:%M")
    # DeliveryOption.new(option: @urgence, delivery: @delivery)
  end

  def volume
    @volume = Volume.find(element[:value])

    @delivery.options << @volume
    # DeliveryOption.new(option: @volume, delivery: @delivery)
  end

  def distance
    
    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: @delivery.pickups.first.address,
        destination: @delivery.drops.first.address,
        mode: "walking",
        key: ENV['GOOGLE_API_KEY']
      }
      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)

      @delivery.distance = (distance['routes'][0]['legs'][0]['distance']['value'])
      @delivery.tickets_distance = ((@delivery.distance / 1000) / 3.5).ceil

      # sum

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def build
    # binding.pry
    @user = User.new()
    @city = City.find_by(name: "Nantes")
    @delivery = Delivery.new(course_params)

    @urgence = Urgence.find_by(id: course_params[:delivery_options_attributes]["0"]["option_id"])
    @volume = Volume.find_by(id: course_params[:delivery_options_attributes]["1"]["option_id"])

    @delivery.options << @urgence
    @delivery.options << @volume
    @drop = @delivery.drops.first
    @pickup = @delivery.pickups.first
    
    # binding.pry
  end

  def sum
    @total = @delivery.tickets_distance + @delivery.urgence.tickets + @delivery.volume.tickets
    @delivery.price_cents = (@total * (600))/100.00
    @before = next_availible_delivery_time(@delivery, @city).strftime("%k:%M")
    @day = next_availible_delivery_time(@delivery, @city).strftime("%A")
    # binding.pry
  end

  def next_availible_delivery_time(delivery, city)
    urgences = city.city_options

    choosen_city_option_rank = delivery.urgence.city_options.find_by( option_id: delivery.urgence).rank # les urgence n'on pas de rank obviously !!!! Et les delivery_options non plus, idiot.
    choosen_city_option_max_value = delivery.urgence.max_value.second

    previous_city_option = CityOption.find_by(rank: (choosen_city_option_rank + 1)) || delivery.urgence.city_options.find_by( option_id: delivery.urgence)
    previous_city_option_max_value = previous_city_option.option.max_value.second 
    
    heure_start, min_start = city.start_hour.split(':').map(&:to_i)
    heure_end, min_end = city.end_hour.split(':').map(&:to_i)
    today_start = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_start, min_start).utc
    today_end = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_end, min_end).utc
    now = Time.now.utc
    # delivery_limit = now + max_value
    
    case 
      when choosen_city_option_rank == 1 #urgence 1 est toujoursdans la journée,
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      when now < today_start
        result = today_start + choosen_city_option_max_value
      when choosen_city_option_rank == 2
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      when choosen_city_option_rank == 3
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      else
        result = now + max_value
    end
    return result
  end

  def course_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end

  def user_params
    params.require(:user).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end

  def email_check(email)
    User.where(email: email).any?
  end

  def delivery_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume, :user,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end
end
