class SimulationOrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    simulation = Simulation.find(cookies[:current_sim])
    simulation_order  = SimulationOrder.create!(simulation: simulation, amount: simulation.price, state: 'pending')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: simulation.s_pickup,
        amount: simulation.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: simulation_order_url(simulation_order),
      cancel_url: simulation_order_url(simulation_order)
    )

    simulation_order.update(checkout_session_id: session.id)
    cookies[:current_session_id] = session.id
    cookies[:sim_order_id] = simulation_order.id
    # redirect_to new_simulation_order_payment_path(simulation_order)
    # raise

  end

end
