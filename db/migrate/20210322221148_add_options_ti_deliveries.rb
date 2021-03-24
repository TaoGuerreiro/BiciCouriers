class AddOptionsTiDeliveries < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :bike_id
    rename_column :courses, :ticket_nb, :tickets_count
    remove_column :courses, :ticket_overflow
    remove_column :courses, :tickets_urgence
    remove_column :courses, :tickets_volume
    remove_reference :courses, :shopping_cart
    add_column :courses, :tour, :boolean, default: false
  end
end
