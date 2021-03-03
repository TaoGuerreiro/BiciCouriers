class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :name
      t.integer :urgence
      t.integer :volume
    end
  end
end
