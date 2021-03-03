class DeleteVolumeAndUrgenceReferencesFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :urgence_id
    remove_column :courses, :volume_id

  end
end
