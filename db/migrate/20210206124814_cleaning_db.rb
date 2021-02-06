class CleaningDb < ActiveRecord::Migration[6.0]
  def change
    remove_column :carnets, :course_overflow
    remove_column :courses, :ticket_overflow
    rename_column :cities, :citiy_name, :name
  end
end
