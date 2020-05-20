class AddStateToSimulations < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :state, :string
    add_column :simulations, :details, :string
    add_column :simulations, :phone, :string
    add_column :simulations, :name, :string

  end
end
