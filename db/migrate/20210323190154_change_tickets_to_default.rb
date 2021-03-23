class ChangeTicketsToDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :options, :tickets, 0
  end
end
