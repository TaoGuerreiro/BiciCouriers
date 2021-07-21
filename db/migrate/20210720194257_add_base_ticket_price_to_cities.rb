class AddBaseTicketPriceToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :base_ticket_price, :integer, default: 6
  end
end
