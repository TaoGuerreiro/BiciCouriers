class AddMaxSizeColumnToVolumes < ActiveRecord::Migration[6.0]
  def change
    add_column :volumes, :max_size, :integer
  end
end
