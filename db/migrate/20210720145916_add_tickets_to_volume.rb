class AddTicketsToVolume < ActiveRecord::Migration[6.0]
  def change
    add_column :volumes, :tickets, :integer, default: 0
  end
end
