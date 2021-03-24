class RenameCoursesTableToDeliveries < ActiveRecord::Migration[6.0]
  def change
    rename_table :courses, :deliveries
  end
end
