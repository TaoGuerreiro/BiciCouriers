class AddDistanceMaxToCarnetTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :carnet_templates, :distance_max, :float
  end
end
