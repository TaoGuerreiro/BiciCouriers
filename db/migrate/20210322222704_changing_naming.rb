class ChangingNaming < ActiveRecord::Migration[6.0]
  def change
    rename_table :carnet_templates, :book_templates
    remove_column :book_templates, :ticket_nb, :tickets_count
    remove_column :book_templates, :distance_max
    add_column :book_templates, :max_distance, :integer, default: 0

    rename_table :carnets, :books
    rename_column :books, :carnet_template_id, :book_templates_id
    rename_column :books, :shopping_cart_id, :order_items
    add_column :books, :status, :string, default: 'draft'
    add_column :books, :price_cents, :integer, default: 0, null: false
  end
end
