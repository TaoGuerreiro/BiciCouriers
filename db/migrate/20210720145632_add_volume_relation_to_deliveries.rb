class AddVolumeRelationToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_reference :deliveries, :volume, null: false, foreign_key: true
  end
end
