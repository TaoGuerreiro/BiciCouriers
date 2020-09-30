class AddDefaultValueToCarnetTemplates < ActiveRecord::Migration[5.2]
  def change
    change_column :carnet_templates, :distance_max, :float, :default => 3.5
  end
end
