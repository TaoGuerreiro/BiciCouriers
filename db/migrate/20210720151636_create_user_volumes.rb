class CreateUserVolumes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_volumes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :volume, null: false, foreign_key: true
    end
  end
end
