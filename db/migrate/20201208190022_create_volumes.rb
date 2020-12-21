class CreateVolumes < ActiveRecord::Migration[6.0]
  def change
    create_table :volumes do |t|
      t.integer :max_weight
      t.string :name

      t.timestamps
    end
  end
end
