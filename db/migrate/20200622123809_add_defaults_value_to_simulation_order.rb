class AddDefaultsValueToSimulationOrder < ActiveRecord::Migration[5.2]
  def change
        change_column :simulation_orders, :state, :string, :default => 'pending'

  end
end
