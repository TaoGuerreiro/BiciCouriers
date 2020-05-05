class ShoppingCartsController < ApplicationController

  def show
    @shopping_cart = ShoppingCart.find(params[:id])
    authorize @shopping_cart
  end

  def show_last
    @commande_en_cours = ShoppingCart.last
  end

  def create
  end

end
