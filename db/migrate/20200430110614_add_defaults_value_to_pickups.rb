class AddDefaultsValueToPickups < ActiveRecord::Migration[5.2]
  def change
    change_column :pickups, :address, :string, required: true
    change_column :pickups, :date, :string, required: true

    change_column :drops, :address, :string, required: true
    change_column :drops, :date, :string, required: true
  end
end
