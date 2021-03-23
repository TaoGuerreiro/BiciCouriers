class ChangeCourseOptionsToDeliveryOtpion < ActiveRecord::Migration[6.0]
  def change
    rename_table :course_options, :delivery_options
    rename_column :delivery_options, :course_id, :delivery_id
  end
end
