class AddCityToAvantages < ActiveRecord::Migration[6.0]
  def change
    add_reference :avantages, :city, foreign_key: true
  end
end
