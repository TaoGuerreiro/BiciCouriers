class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :build

  def urgence
    @urgence = Urgence.find(element[:value])
    DeliveryOption.new(option: @urgence, delivery: @delivery)
  end

  def volume
    @volume = Volume.find(element[:value])
    DeliveryOption.new(option: @volume, delivery: @delivery)
  end

  def distance
    @delivery = Delivery.new(course_params)
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

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def build
    @delivery = Delivery.new(course_params)
    @urgence = Urgence.new(course_params[:delivery_options_attributes][0])
    @volume = Volume.new(course_params[:delivery_options_attributes][0])
  end

  def total

  end

  def course_params
    params.require(:delivery).permit(:details, :bike_id, :distance, :tickets_distance, :tickets_urgence, :tickets_volume,
                                    drops_attributes:[:id, :date, :details, :address, :start_hour, :end_hour, :favorite_address],
                                    pickups_attributes:[:id, :details, :date, :address, :start_hour, :end_hour, :favorite_address],
                                    delivery_options_attributes:[ :option_id, :user_option])
  end
end
