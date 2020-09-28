class ChangeDropsAndPickupsHoursToStrings < ActiveRecord::Migration[5.2]
  def change
        change_column :pickups, :start_hour, :string
        change_column :pickups, :end_hour, :string
        change_column :drops, :start_hour, :string
        change_column :drops, :end_hour, :string
  end
end
