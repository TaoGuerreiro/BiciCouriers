class RenameUserOptionsId < ActiveRecord::Migration[6.0]
  def change
    remove_reference :course_options, :user_options
    add_reference :course_options, :user_option
  end
end
