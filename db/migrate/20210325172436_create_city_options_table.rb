class CreateCityOptionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :city_options_tables do |t|
      t.references :city, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
