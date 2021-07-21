class AddRankToCityUrgence < ActiveRecord::Migration[6.0]
  def change
    add_column :city_urgences, :rank, :integer
  end
end
