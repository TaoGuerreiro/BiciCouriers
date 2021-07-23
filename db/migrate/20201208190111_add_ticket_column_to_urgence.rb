class AddTicketColumnToUrgence < ActiveRecord::Migration[6.0]
  def change
    create_table :urgences do |t|
      t.timestamps
    end
    add_column :urgences, :ticket, :integer
  end
end
