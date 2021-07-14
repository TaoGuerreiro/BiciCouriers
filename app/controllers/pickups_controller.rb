class PickupsController < ApplicationController
  before_action :skip_authorization, only: [:new, :create]

  def new
    @delivery = Delivery.find(params[:delivery_id])
    @pickup ||= Pickup.new
    authorize @pickup
  end

end
