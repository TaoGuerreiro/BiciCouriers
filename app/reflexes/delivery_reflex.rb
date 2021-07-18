class DeliveryReflex < ApplicationReflex
  include Pundit
  delegate :current_user, to: :connection
  before_reflex :skip_authorization, only: [:create_pickup, :create_drop]

  def create_pickup
    # binding.pry
    delivery = Delivery.find(element.dataset.delivery_id)
    # if delivery.pickups.any?
    #   @pickup = delivery.pickups.last.update!(pickup_params)
    # else
      @pickup = delivery.pickups.create!(pickup_params)
    # end
    # @pickup = Pickup.new if @pickup.persisted?
    morph :nothing
  end

  def create_drop
    # binding.pry
    delivery = Delivery.find(element.dataset.delivery_id)
    # if delivery.drops.any?
    #   @drop = delivery.drops.last.update!(drop_params)
    # else
      @drop = delivery.drops.create!(drop_params)
    # end
    # @drop = Pickup.new if @drop.persisted?
    morph :nothing
  end

  def distance
    binding.pry
    # begin
    #   url = 'https://maps.googleapis.com/maps/api/directions/json?'
    #   query = {
    #     origin: @delivery.pickups.first.address,
    #     destination: @delivery.drops.first.address,
    #     mode: "walking",
    #     key: ENV['GOOGLE_API_KEY']
    #   }
    #   distance = JSON.parse(HTTParty.get(
    #     url,
    #     query: query
    #   ).body)

    #   @delivery.distance = (distance['routes'][0]['legs'][0]['distance']['value'])
    #   @delivery.tickets_distance = ((@delivery.distance / 1000) / 3.5).ceil

    #   # sum

    # rescue NoMethodError
    #   # distance = "Je calcul..."
    #  end
  end




  private

  def pickup_params
    params.require(:pickup).permit(:address, :start_hour, :end_hour)
  end

  def drop_params
    params.require(:drop).permit(:address, :start_hour, :end_hour)
  end
end
