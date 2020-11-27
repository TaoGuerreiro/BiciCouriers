class CreateUrgences < ActiveRecord::Migration[5.2]
  def change
    create_table :urgences do |t|
      t.integer :range
      t.string :name

      t.timestamps
    end
  end
end
