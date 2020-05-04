class AddCourseOverflowToCarnets < ActiveRecord::Migration[5.2]
  def change
    add_column :carnets, :course_overflow, :integer, default: 0
  end
end
