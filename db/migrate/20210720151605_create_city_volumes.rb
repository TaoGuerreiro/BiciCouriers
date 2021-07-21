class CreateCityVolumes < ActiveRecord::Migration[6.0]
  def change
    create_table :city_volumes do |t|
      t.references :city, null: false, foreign_key: true
      t.references :volume, null: false, foreign_key: true
    end
  end
end
