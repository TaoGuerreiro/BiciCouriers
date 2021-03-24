class ChangeBooksToTicketsBooks < ActiveRecord::Migration[6.0]
  def change
    rename_table :books, :tickets_books

  end
end
