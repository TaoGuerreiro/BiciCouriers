class SimulationPaymentsController < ApplicationController
  def new
    @simulation_order = SimulationOrder.where(state: 'pending').find(params[:order_id])
  end
end
