class ChangeCarnetIdToBookId < ActiveRecord::Migration[6.0]
  def change
    remove_reference :deliveries, :carnet
  end
end
