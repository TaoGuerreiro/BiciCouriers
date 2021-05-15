class AddingUrgenceReferencesToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_reference :deliveries, :urgence
  end
end
