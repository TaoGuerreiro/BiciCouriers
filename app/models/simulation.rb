class Simulation < ApplicationRecord
  has_many :simulation_orders
  monetize :price_cents
end
