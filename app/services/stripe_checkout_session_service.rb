class StripeCheckoutSessionService
  def call(event)
    raise
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')
    # order.last.shopping_cart.update(state: 'paid')
    create_shopping_cart
  end

private

def create_shopping_cart
  ShoppingCart.create(user: current_user)
end

end
