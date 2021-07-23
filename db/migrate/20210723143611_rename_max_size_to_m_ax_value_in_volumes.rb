class RenameMaxSizeToMAxValueInVolumes < ActiveRecord::Migration[6.0]
  def change
    rename_column :volumes, :max_size, :max_weight
  end
end
