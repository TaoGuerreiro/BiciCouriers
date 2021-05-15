class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :build
  after_reflex :sum

  def urgence
    @urgence = Urgence.find(element[:value])
    @delivery.options << @urgence
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
    @delivery = Delivery.new(course_params)
    @urgence = Urgence.find_by(id: course_params[:delivery_options_attributes]["0"]["option_id"])
    @volume = Volume.find_by(id: course_params[:delivery_options_attributes]["1"]["option_id"])
    @delivery.options << @urgence
    @delivery.options << @volume
  end

  def sum
    @total = @delivery.tickets_distance + @delivery.urgence.tickets + @delivery.volume.tickets
    @delivery.price_cents = (@total * (600))/100.00
  end

  def course_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end
end
