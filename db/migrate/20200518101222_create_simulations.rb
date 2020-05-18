class CreateSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :simulations do |t|
      t.string :s_pickup
      t.string :s_drop
      t.string :s_urgence
      t.string :s_volume

      t.timestamps
    end
  end
end
