class ChangeMailToEmail < ActiveRecord::Migration[6.0]
  def change
    rename_column :cities, :mail, :email
  end
end
