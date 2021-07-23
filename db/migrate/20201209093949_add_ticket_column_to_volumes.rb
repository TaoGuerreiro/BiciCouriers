class AddTicketColumnToVolumes < ActiveRecord::Migration[6.0]
  def change
    create_table :volumes do |t|
      t.timestamps
    end
    add_column :volumes, :ticket, :integer
  end
end
