class RemoveDateFromPickups < ActiveRecord::Migration[5.2]
  def change
    remove_column :pickups, :date
  end
end
