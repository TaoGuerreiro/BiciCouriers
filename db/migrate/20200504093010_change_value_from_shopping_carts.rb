class ChangeValueFromShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shopping_carts, :price_currency

  end
end
