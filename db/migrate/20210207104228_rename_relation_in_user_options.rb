class RenameRelationInUserOptions < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_options, :volumes_id,  :volume_id
    rename_column :user_options, :urgences_id,  :urgence_id
  end
end
