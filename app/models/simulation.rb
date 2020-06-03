class Simulation < ApplicationRecord
  has_many :simulation_orders
  monetize :price_cents

  validates :s_pickup, presence: true
  validates :s_drop, presence: true
end
