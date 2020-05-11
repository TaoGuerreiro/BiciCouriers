class AddBillingInfoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :billing_company, :string
  end
end
