class AddImageToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :image, :string
  end
end
