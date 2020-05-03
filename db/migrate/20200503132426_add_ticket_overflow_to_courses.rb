class AddTicketOverflowToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :ticket_overflow, :integer, default: 0
  end
end
