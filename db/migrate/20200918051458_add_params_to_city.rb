class AddParamsToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :start_hour, :string, default: "08:00"
    add_column :cities, :end_hour, :string, default: "19:00"
    add_column :cities, :cargo_nb, :integer, default: 1
    add_column :cities, :distance_per_ticket, :float, default: 3500
    add_column :cities, :urgence_one_size, :integer, default: 2700
    add_column :cities, :urgence_two_size, :integer, default: 14400
  end
end
