class AddVolumeIdToUserOptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_options, :urgences, foreign_key: true
    add_reference :user_options, :volumes, foreign_key: true
  end
end
