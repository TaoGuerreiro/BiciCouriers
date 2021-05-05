class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :build
  # after_reflex :total

  def urgence
    @delivery = Delivery.new(course_params)
    @selected_urgence = Urgence.find(element[:value])
    # @delivery.options << @selected_urgence
    
    binding.pry
    # puts "*" * 200
    # puts @selected_urgence.tickets
    # puts "*" * 200
    # # @selected_urgence.tickets
    # @delivery = Delivery.new(course_params)
  end

  def volume
    @selected_volume = Volume.find(element[:value])
    # binding.pry

    # puts "*" * 200
    # puts @selected_volume.tickets
    # puts "*" * 200
    # puts "X" * 200
    # puts params
    # puts "X" * 200
    # # @course.tickets_volume = @selected_volume.ticket
    # @delivery = Delivery.new(course_params)
  end

  def distance
    @delivery = Delivery.new(course_params)
    # binding.pry
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

      # puts "PARAMS_START" * 200
      # puts course_params
      # puts @delivery.first
      # puts "PARAMS_end" * 200
      # @builded_delivery = Delivery.new(@delivery)
      # return @delivery
      # display_params
      # binding.pry

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def build
    @delivery = Delivery.new(course_params)
    puts "XXXXXXXX" 
    puts params
    puts "XXXXXXXX" 

    # @total = (@delivery.tickets_distance) + ( 50 || (@delivery.delivery_options.first.option.tickets)) + ( 100 || (@delivery.delivery_options.last.option.tickets))
    # binding.pry
    # @course.drops.reset
    # @course.pickups.reset
    # @course.course_options.reset
  end

  def total
    # @total_delivery = Delivery.new(course_params)
    # @total = (@delivery.tickets_distance) + ( 55 || (@delivery.delivery_options.first.option.tickets)) + ( 66 || (@delivery.delivery_options.last.option.tickets))
    binding.pry
    # display_params
  end

  def course_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end

  def display_params
    puts "XXXXXXXX" 
    puts params
    puts "XXXXXXXX" 
  end


end
