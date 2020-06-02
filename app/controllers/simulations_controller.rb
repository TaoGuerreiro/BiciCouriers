class SimulationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]


  def create
    @simulation = Simulation.new(simu_params)
    @simulation.save
    respond_to do |format|
          format.json { render json: { id: @simulation.id } }
    end
    cookies[:current_sim_id] = @simulation.id
    # @simulation.price_cents = ((params[:s_volume] + params[:s_urgence] + params[:s_distance]) * 583 )
  end


  def index
    simulation = Simulation.find(cookies[:current_sim_id])
    render json: simulation, only: [:id]
  end

  private

  def simu_params
    params.require(:simulation).permit(:s_pickup, :s_drop, :s_volume, :s_urgence, :s_distance, :name, :details, :phone, :price_cents)
  end
end
