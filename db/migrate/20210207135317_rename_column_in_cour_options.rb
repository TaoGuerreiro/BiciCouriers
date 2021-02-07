class RenameColumnInCourOptions < ActiveRecord::Migration[6.0]
  def change
    rename_column :course_options, :courses_id,  :course_id
  end
end
