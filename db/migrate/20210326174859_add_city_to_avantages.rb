class AddCityToAvantages < ActiveRecord::Migration[6.0]
  def change
    add_reference :avantages, :city, null: false, foreign_key: true
  end
end
