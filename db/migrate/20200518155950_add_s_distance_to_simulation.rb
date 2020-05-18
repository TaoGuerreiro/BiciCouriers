class AddSDistanceToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :s_distance, :integer, default: 0
    remove_column :simulations, :s_volume
    remove_column :simulations, :s_urgence
  end
end
