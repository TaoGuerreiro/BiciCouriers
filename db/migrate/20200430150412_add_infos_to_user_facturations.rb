class AddInfosToUserFacturations < ActiveRecord::Migration[5.2]
  def change
    add_column :user_facturations, :facturation_address, :string
    add_column :user_facturations, :facturation_company, :string
    add_column :user_facturations, :facturation_first_name, :string
    add_column :user_facturations, :facturation_last_name, :string
  end
end
