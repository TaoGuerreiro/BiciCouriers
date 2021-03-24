class AddChangeToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :pool
    rename_column :users, :carnet_renewal, :tickets_book_renewal
  end
end
