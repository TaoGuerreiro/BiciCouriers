class CreateCityUrgences < ActiveRecord::Migration[6.0]
  def change
    create_table :city_urgences do |t|
      t.references :city, null: false, foreign_key: true
      t.references :urgence, null: false, foreign_key: true
    end
  end
end
