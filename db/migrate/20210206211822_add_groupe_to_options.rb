class AddGroupeToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :groupe, :integer
  end
end
