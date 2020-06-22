class AddDefaultsValueToSimulation < ActiveRecord::Migration[5.2]
  def change
    change_column :simulations, :state, :string, :default => 'pending'
  end
end
