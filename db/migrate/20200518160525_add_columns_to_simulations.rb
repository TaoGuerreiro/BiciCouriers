class AddColumnsToSimulations < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :s_volume, :integer, default: 0
    add_column :simulations, :s_urgence, :integer, default: 0
  end
end
