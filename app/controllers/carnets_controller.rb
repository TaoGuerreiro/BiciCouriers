class CarnetsController < ApplicationController


  def index
    @inprogress = policy_scope(Carnet).where('remaining_tickets > ?', 0).order(created_at: :desc)
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


    if commande_en_cours?
      # raise
        add_carnet_to_shopping_cart(@carnet, @user.shopping_carts.last)
        @user.shopping_carts.last.save
      else
        create_shopping_cart
        add_carnet_to_shopping_cart(@carnet, @new_shopping_cart)
        @new_shopping_cart.save
      end

    authorize @carnet
    if @carnet.save
      # raise
      @carnet.save
      @user.save
      redirect_to shopping_cart_path(current_user.shopping_carts.last)
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

    if (@user.shopping_carts == nil || @user.shopping_carts == [])
      return false
    else
     @user.shopping_carts.last.state == 'pending'
    end
  end

  def create_shopping_cart
    @new_shopping_cart = ShoppingCart.create(user: @user)
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
