class AddNameToUrgence < ActiveRecord::Migration[6.0]
  def change
    add_column :urgences, :name, :string
    add_column :volumes, :name, :string
  end
end
