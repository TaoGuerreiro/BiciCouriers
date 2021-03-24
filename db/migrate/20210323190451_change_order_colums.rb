class ChangeOrderColums < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :state, :status
    remove_reference :orders, :shopping_cart

  end
end
