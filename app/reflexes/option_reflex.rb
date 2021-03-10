class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection

  after_reflex :total

  def urgence
    @course = Course.new(course_params)
    @selected_urgence = Urgence.find(element[:value])
    @course.tickets_urgence = @selected_urgence.ticket
  end

  def volume
    @course = Course.new(course_params)
    @selected_volume = Volume.find(element[:value])
    @course.tickets_volume = @selected_volume.ticket
  end

  def distance
    @course = Course.new(course_params)

    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: @course.pickups.first.address,
        destination: @course.drops.first.address,
        key: ENV['GOOGLE_API_KEY']
      }

      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)

      @course.distance = (distance['routes'][0]['legs'][0]['distance']['value'])
      @course.tickets_distance = ((@course.distance / 1000) / 3.5).ceil

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def total

    @test = Course.new(course_params)
    @total = (@test.tickets_distance) + (@test.tickets_volume) + (@test.tickets_urgence)
    # binding.pry
  end

  def course_params
    params.require(:course).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    course_options_attributes:[ :user_option_id])
  end


end
