class PickupReflex < ApplicationReflex
include Pundit
delegate :current_user, to: :connection
before_reflex :skip_authorization, only: [:create]


  def create
    # binding.pry
    @delivery = Delivery.find(params[:delivery_id])

    @pickup = @delivery.pickups.create(pickup_params)
    @pickup = Pickup.new if @pickup.persisted?
    authorize @pickup
  end

  private

    def pickup_params
          params.require(:pickup).permit(:date, :details, :address, :start_hour, :end_hour)
    end
end