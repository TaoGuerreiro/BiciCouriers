class RenameCourseToDelivery < ActiveRecord::Migration[6.0]
  def change
    rename_column :drops, :course_id, :delivery_id
    rename_column :pickups, :course_id, :delivery_id
  end
end
