class AddTimestampToOptionsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :created_at, :datetime, null: false
    add_column :options, :updated_at, :datetime, null: false
  end
end
