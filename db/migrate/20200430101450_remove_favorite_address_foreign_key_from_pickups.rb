class RemoveFavoriteAddressForeignKeyFromPickups < ActiveRecord::Migration[5.2]
  def change
    remove_column :pickups, :favorite_address_id, :integer
  end
end
