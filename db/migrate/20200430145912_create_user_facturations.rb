class CreateUserFacturations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_facturations do |t|

      t.timestamps
    end
  end
end
