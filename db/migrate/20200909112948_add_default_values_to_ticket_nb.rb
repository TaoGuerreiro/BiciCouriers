class AddDefaultValuesToTicketNb < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :ticket_nb, :integer, default: 0
  end
end
