class CreateCourseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :course_options do |t|
      t.references :user_options, null: false, foreign_key: true
      t.references :courses, null: false, foreign_key: true
    end
  end
end
