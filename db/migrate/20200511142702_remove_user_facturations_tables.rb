class RemoveUserFacturationsTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_facturations
  end
end
