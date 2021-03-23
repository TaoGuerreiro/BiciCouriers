class AddPhoneAndMailToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :phone, :string
    add_column :cities, :mail, :string
  end
end
