class SimulationOrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :index, :show]


  def calcul_distance

  end

  def show
    redirect_to root_path
  end

  def create
    # raise
    # simulation = Simulation.find(cookies[:current_sim_id])
    # simulation_order  = SimulationOrder.create!(simulation: simulation, amount: simulation.price, state: 'pending')

    # session = Stripe::Checkout::Session.create(
    #   payment_method_types: ['card'],
    #   line_items: [{
    #     name: simulation.s_drop,
    #     amount: simulation.price_cents,
    #     currency: 'eur',
    #     quantity: 1
    #   }],
    #   success_url: simulation_order_url(simulation_order),
    #   cancel_url: simulation_order_url(simulation_order)
    # )

    # simulation_order.update(checkout_session_id: session.id)
    # cookies[:sim_order_id] = simulation_order.id
    # redirect_to new_simulation_order_payment_path(simulation_order)
    # redirect_to root_path
    # respond_to do |format|
    #       format.json { render json: { checkout_session_id: session.id } }
    # end
    # raise


  end

  # def index
  #   simulation_order = SimulationOrder.find(cookies[:sim_order_id])
  #   render json: simulation_order, only: [:id, :checkout_session_id]
  # end

end
