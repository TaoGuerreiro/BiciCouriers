class AddColumnsToFavoriteAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :favorite_addresses, :address, :string
    add_column :favorite_addresses, :details, :string
    add_column :favorite_addresses, :start_hour, :integer
    add_column :favorite_addresses, :end_hour, :integer
  end
end
