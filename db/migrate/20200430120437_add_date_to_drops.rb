class AddDateToDrops < ActiveRecord::Migration[5.2]
  def change
    add_column :drops, :date, :date, required: true
  end
end
