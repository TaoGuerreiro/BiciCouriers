class RenameColumnsInUserOptions < ActiveRecord::Migration[6.0]
  def change

    rename_column :user_options, :users_id,  :user_id
    rename_column :user_options, :options_id,  :option_id
  end
end
