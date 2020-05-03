class ChangeStartAndEndHourFromPickupsToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :pickups, :start_hour, :float, required: true
    change_column :pickups, :end_hour, :float, required: true

    change_column :drops, :start_hour, :float, required: true
    change_column :drops, :end_hour, :float, required: true
  end
end
