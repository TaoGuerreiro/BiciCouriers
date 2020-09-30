class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:success, :cancel]
  before_action :skip_authorization, only: [:success, :cancel]



  def index
    @orders = policy_scope(Order).where(user: current_user)
  end

  def create
    shopping_cart = ShoppingCart.find(params[:shopping_cart_id])
    order  = Order.create!(shopping_cart: shopping_cart, amount: shopping_cart.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Nouvelle commande',
        # images: [shopping_cart.photo_url],
        amount: (shopping_cart.price_cents * 1.2).ceil.to_i,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
    authorize order
  end

  def show
    @order = current_user.orders.find(params[:id])
    authorize @order
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = @session.customer
    redirect_to root_path, flash: {alert: 'Course bien envoyé à nos bureaux 😎​🚴​'}
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = @session.customer
    redirect_to root_path, flash: {alert: 'Un problème est survenu 😔​'}
  end

  private

  def order_params
    params.require(:order).permit(:shopping_cart_id, :amount)
  end


end
