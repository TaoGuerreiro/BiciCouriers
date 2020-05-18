class SimulationsController < ApplicationController

  def new
    @simulation = Simulation.new
  end
end
