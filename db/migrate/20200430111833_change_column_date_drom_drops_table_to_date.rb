class ChangeColumnDateDromDropsTableToDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :drops, :date
  end
end
