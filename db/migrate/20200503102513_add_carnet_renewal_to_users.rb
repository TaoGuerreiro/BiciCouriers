class AddCarnetRenewalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :carnet_renewal, :boolean, default: true
  end
end
