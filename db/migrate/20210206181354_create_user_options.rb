class CreateUserOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_options do |t|
      t.references :users, null: false, foreign_key: true
      t.references :options, null: false, foreign_key: true
    end
  end
end
