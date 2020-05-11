class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(state: 'paid')
    order.shopping_cart.update(state: 'paid')
    # customer = User.find(params[:user_id])
    # create_shopping_cart(customer)
  end

private

# def create_shopping_cart(user)
#   ShoppingCart.create(user: user)
# end

end
