class AddDraftIdToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :draft_id, :string
  end
end
