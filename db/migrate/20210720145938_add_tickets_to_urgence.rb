class AddTicketsToUrgence < ActiveRecord::Migration[6.0]
  def change
    add_column :urgences, :tickets, :integer, default: 0
  end
end
