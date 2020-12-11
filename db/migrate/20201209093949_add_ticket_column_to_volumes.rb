class AddTicketColumnToVolumes < ActiveRecord::Migration[6.0]
  def change
    add_column :volumes, :ticket, :integer
  end
end
