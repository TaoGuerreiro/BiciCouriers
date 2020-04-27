class CreateFavoriteAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_addresses do |t|

      t.timestamps
    end
  end
end
