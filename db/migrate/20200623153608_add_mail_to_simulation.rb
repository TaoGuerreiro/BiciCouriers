class AddMailToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :mail, :string
  end
end
