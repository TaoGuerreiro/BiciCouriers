class AddDefaultValuesToCourses < ActiveRecord::Migration[5.2]
  def change
    change_column :courses, :tickets_volume, :integer, default: 0
    change_column :courses, :tickets_distance, :integer, default: 0
    change_column :courses, :tickets_urgence, :integer, default: 0
    add_monetize :courses, :price, currency: { present: false }
  end
end
