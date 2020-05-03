class RemoveFavoriteAddressForeignKeyFromDrops < ActiveRecord::Migration[5.2]
  def change
    remove_column :drops, :favorite_address_id, :integer
  end
end
