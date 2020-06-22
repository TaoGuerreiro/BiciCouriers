class StripeCheckoutSessionService
  def call(event)
    # if Order.find_by(checkout_session_id: event.data.object.id).present?
    #   order = Order.find_by(checkout_session_id: event.data.object.id)
    #   order.update(state: 'paid')
    #   order.shopping_cart.update(state: 'paid')
    # else
      order = SimulationOrder.find_by(checkout_session_id: event.data.object.id)
      @simulation = order.simulation if order.present?


      # order.shopping_cart.update(state: 'paid')
    # customer = User.find(params[:user_id])
    # create_shopping_cart(customer)
    # end
  end

  # def update_simulation
  #   simulation.update(state: 'paid')
  # end

  def update_order
    send_course_info_to_dispatch
    order.update(state: 'paid')
  end

private

  def send_course_info_to_dispatch
    DispatchMailer.with(simulation: @simulation).new_simulation.deliver_now
  end
# def create_shopping_cart(user)
#   ShoppingCart.create(user: user)
# end

end
