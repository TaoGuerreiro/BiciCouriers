class CreateUserUrgences < ActiveRecord::Migration[6.0]
  def change
    create_table :user_urgences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :urgence, null: false, foreign_key: true
    end
  end
end
