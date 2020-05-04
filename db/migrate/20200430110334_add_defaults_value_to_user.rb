class AddDefaultsValueToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :paper_invoice, :boolean, :default => false
  end
end
