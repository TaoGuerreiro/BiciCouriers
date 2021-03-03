class AddTimestampToUserOptionsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :user_options, :created_at, :datetime, null: false
    add_column :user_options, :updated_at, :datetime, null: false
  end
end
