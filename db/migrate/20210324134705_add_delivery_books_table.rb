class AddDeliveryBooksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_books do |t|
      t.references :delivery, foreign_key: true
      t.references :tickets_book, foreign_key: true
      t.integer :tickets, default: 0

      t.timestamps
    end
  end
end
