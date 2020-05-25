class CreateSimulationOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :simulation_orders do |t|
      t.string :state
      t.monetize :amount, currency: { present: false }
      t.string :checkout_session_id
      t.references :simulation, foreign_key: true

      t.timestamps
    end
  end
end
