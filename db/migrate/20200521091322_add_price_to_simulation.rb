class AddPriceToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_monetize :simulations, :price, currency: { present: false }

  end
end
