class SimulationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  # def new
  #   @simulation = Simulation.new
  #   @simulation_order = SimulationOrder.new
  # end

  def create
    @simulation = Simulation.new(simu_params)
    @simulation.save
    cookies[:current_sim] = @simulation.id
    # @simulation.price_cents = ((params[:s_volume] + params[:s_urgence] + params[:s_distance]) * 583 )
  end

  private

  def simu_params
    params.require(:simulation).permit(:s_pickup, :s_drop, :s_volume, :s_urgence, :s_distance, :name, :details, :phone, :price_cents)
  end
end
