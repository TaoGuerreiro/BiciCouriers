class AddCitiyReferenceToContacts < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :city
  end
end
