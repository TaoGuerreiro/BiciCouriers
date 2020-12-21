class RenameVolumesColumInCourses < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :volumes_id,  :volume_id
    rename_column :courses, :urgences_id,  :urgence_id
  end
end
