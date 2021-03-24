class AddToReferencesNullToTrueInUserOptions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_options, :option_id, true
  end
end
