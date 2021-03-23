class RemoveStateFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :state
  end
end
