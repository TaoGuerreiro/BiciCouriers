class AddStateToShoppingCart < ActiveRecord::Migration[5.2]
  def change
    add_column :shopping_carts, :state, :string, default: 'pending'
  end
end
