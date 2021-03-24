class ChangeToOptions < ActiveRecord::Migration[6.0]
  def change
    rename_column :options, :ticket_nb, :tickets
    add_column :options, :type, :string
    add_column :options, :max_value, :integer, default: 0

  end
end
