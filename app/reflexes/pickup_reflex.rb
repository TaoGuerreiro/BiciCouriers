class PickupReflex < ApplicationReflex
include Pundit
delegate :current_user, to: :connection
before_reflex :skip_authorization, only: [:create]


  def create
    @delivery = Delivery.find_by
    @pickup = Pickup.create
  end

  private

    def pickup_params
          params.require(:pickup).permit(:date, :details, :address, :start_hour, :end_hour)
    end
end
