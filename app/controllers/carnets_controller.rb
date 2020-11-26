class CarnetsController < ApplicationController


  def index
    @inprogress = policy_scope(Carnet).joins(:shopping_cart).where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid').order(created_at: :desc)

    RentalRequest.joins(:instrument).where(instruments: { user: current_user })
    # raise
    @oldone = policy_scope(Carnet).where('remaining_tickets <= ?', 0).order(created_at: :desc)
  end

  def show
    @carnet = Carnet.find(params[:id])
    authorize @carnet
  end

  def new
    @carnet_templates = CarnetTemplate.all
    @carnet = Carnet.new
    authorize @carnet
  end

  def create
    @carnet = Carnet.new(carnet_params)
    @user = current_user
    @carnet.user = current_user
    @carnet.remaining_tickets = @carnet.carnet_template.ticket_nb
    @shopping_cart = @user.shopping_carts.last


    if commande_en_cours?
      # raise
        add_carnet_to_shopping_cart(@carnet, @shopping_cart )
        @user.shopping_carts.last.save
      else
        create_shopping_cart
        add_carnet_to_shopping_cart(@carnet, @shopping_cart)
        @shopping_cart.save
      end

    authorize @carnet
    if @carnet.save
      # raise
      @carnet.save
      @user.save
      redirect_to shopping_cart_path(@shopping_cart)
    else
    # raise
      render :new
    end
  end

  def destroy
    @cart = ShoppingCart.last
    @carnet = Carnet.find(params[:id])
    remove_carnet_from_shopping_cart(@carnet, @cart)

    @carnet.destroy
    redirect_to shopping_cart_path(ShoppingCart.last.id)
    authorize @carnet
  end

  private

  def carnet_params
        params.require(:carnet).permit(:carnet_template_id)
  end

  def commande_en_cours?
    @user.shopping_carts.blank? ? false : @user.shopping_carts.last.state == 'pending'
  end

  def create_shopping_cart
    @shopping_cart = ShoppingCart.create(user: @user)
  end

  def add_carnet_to_shopping_cart(carnet, cart)
    carnet.shopping_cart = cart
    cart.price_cents = cart.price_cents + (carnet.carnet_template.price_cents * carnet.carnet_template.ticket_nb)
    cart.save
  end

  def remove_carnet_from_shopping_cart(carnet, cart)
    carnet.shopping_cart = cart
    cart.price_cents = cart.price_cents - (carnet.carnet_template.price_cents * carnet.carnet_template.ticket_nb)
    cart.save
  end

end
