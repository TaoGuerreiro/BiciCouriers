class RenameBookTemplateId < ActiveRecord::Migration[6.0]
  def change
    rename_column :tickets_books, :book_templates_id, :book_template_id
    remove_column :tickets_books, :order_items
  end
end
