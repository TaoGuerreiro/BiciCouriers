class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|

      t.timestamps
    end
  end
end
