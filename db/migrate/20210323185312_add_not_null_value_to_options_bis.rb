class AddNotNullValueToOptionsBis < ActiveRecord::Migration[6.0]
  def change
    change_column_null :delivery_options, :option_id, false
  end
end
