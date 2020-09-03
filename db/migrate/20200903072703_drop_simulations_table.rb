class DropSimulationsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :simulation_orders
    drop_table :simulations
  end
end
