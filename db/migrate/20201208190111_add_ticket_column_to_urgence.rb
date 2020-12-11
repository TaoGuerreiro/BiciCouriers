class AddTicketColumnToUrgence < ActiveRecord::Migration[6.0]
  def change
    add_column :urgences, :ticket, :integer
  end
end
