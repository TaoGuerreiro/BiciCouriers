class ChangeShoppingCartToOrderItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :shopping_carts, :order_items
    remove_column :order_items, :price_cents
    remove_reference :order_items, :user
    # add_column :order_items, :item_type, :string
    add_reference :order_items, :item, polymorphic: true
    add_reference :order_items, :order
  end
end
