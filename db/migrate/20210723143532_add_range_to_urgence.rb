class AddRangeToUrgence < ActiveRecord::Migration[6.0]
  def change
    add_column :urgences, :range, :integer
  end
end
