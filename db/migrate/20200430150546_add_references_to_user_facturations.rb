class AddReferencesToUserFacturations < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_facturations, :user, foreign_key: true
  end
end
