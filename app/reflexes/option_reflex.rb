class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :build
  after_reflex :total

  def urgence
    # binding.pry
    @selected_urgence = Urgence.find(element[:value])
    # @selected_urgence.tickets
  end

  def volume
    @selected_volume = Volume.find(element[:value])
    # @course.tickets_volume = @selected_volume.ticket
  end

  def distance
    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: @delivery.pickups.first.address,
        destination: @delivery.drops.first.address,
        key: ENV['GOOGLE_API_KEY']
      }
      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)

      @delivery.distance = (distance['routes'][0]['legs'][0]['distance']['value'])
      @delivery.tickets_distance = ((@delivery.distance / 1000) / 3.5).ceil

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def build
    # binding.pry
    @delivery = Delivery.new(course_params)
    # @course.drops.reset
    # @course.pickups.reset
    # @course.course_options.reset
  end

  def total
    @test = Delivery.new(course_params)
    @total = (@test.tickets_distance) + (@test.delivery_options.first.option.tickets) + (@test.delivery_options.last.option.tickets)
    # binding.pry
  end

  def course_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end


end
