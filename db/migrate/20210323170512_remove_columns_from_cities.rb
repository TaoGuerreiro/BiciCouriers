class RemoveColumnsFromCities < ActiveRecord::Migration[6.0]
  def change
    remove_column :cities, :cargo_nb
    remove_column :cities, :distance_per_ticket
    remove_column :cities, :urgence_one_size
    remove_column :cities, :urgence_two_size
  end
end
