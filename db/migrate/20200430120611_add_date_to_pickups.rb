class AddDateToPickups < ActiveRecord::Migration[5.2]
  def change
    add_column :pickups, :date, :date, required: true
  end
end
