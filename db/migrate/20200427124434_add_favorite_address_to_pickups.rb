class AddFavoriteAddressToPickups < ActiveRecord::Migration[5.2]
  def change
    add_reference :pickups, :favorite_address, foreign_key: true
  end
end
