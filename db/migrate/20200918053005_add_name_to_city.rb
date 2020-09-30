class AddNameToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :city_name, :string
  end
end
