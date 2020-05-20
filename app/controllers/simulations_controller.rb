class SimulationsController < ApplicationController

  def new
    @simulation = Simulation.new
  end

  def create
    @simulation = Simulation.new(simu_params)


  end

  private

  def simu_params
    params.require(:course).permit(:s_pickup, :s_drop, :s_volume, :s_urgence, :s_distance, :name, :details, :phone)
  end
end
