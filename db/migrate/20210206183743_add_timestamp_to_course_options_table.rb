class AddTimestampToCourseOptionsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :course_options, :created_at, :datetime, null: false
    add_column :course_options, :updated_at, :datetime, null: false
  end
end
