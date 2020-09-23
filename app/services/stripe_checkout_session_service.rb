class StripeCheckoutSessionService
  def call(event)
      order = Order.find_by(checkout_session_id: event.data.object.id)
      order.update(state: 'paid')
      order.shopping_cart.update(state: 'paid')
      send_course_info_to_dispatch(order)
  end

private

def send_course_info_to_dispatch(order)
  DispatchMailer.with(course: order.shopping_cart.courses.last).new_payement.deliver_now
end


end
