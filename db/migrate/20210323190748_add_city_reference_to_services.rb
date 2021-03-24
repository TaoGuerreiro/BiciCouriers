class AddCityReferenceToServices < ActiveRecord::Migration[6.0]
  def change
    add_reference :services, :city
  end
end
