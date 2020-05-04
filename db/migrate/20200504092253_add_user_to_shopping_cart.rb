class AddUserToShoppingCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :shopping_carts, :user, foreign_key: true
  end
end
