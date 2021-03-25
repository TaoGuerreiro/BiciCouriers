class ChangeCityOptionsTableToCityOptions < ActiveRecord::Migration[6.0]
  def change
    rename_table :city_options_tables, :city_options
  end
end
