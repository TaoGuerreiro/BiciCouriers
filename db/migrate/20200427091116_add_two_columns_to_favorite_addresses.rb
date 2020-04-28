class AddTwoColumnsToFavoriteAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :favorite_addresses, :title, :string
    add_reference :favorite_addresses, :user, foreign_key: true
  end
end
