class AddingDefaultValueToDistance < ActiveRecord::Migration[6.0]
  def change
    change_column_default :deliveries, :distance, 0
  end
end
