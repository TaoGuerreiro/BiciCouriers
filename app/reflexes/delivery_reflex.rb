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
  end





  private

  def pickup_params
    params.require(:pickup).permit(:address, :start_hour, :end_hour)
  end

  def drop_params
    params.require(:drop).permit(:address, :start_hour, :end_hour)
  end
end
