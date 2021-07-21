class AddRankToCityOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :city_options, :rank, :integer
  end
end
