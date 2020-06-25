class Simulation < ApplicationRecord
  has_many :simulation_orders
  monetize :price_cents

  validates :s_pickup, presence: true
  validates :s_drop, presence: true

  # after_create :send_simulation_info_to_dispatch


  private

  # def send_simulation_info_to_dispatch
  #   DispatchMailer.with(simulation: self).new_simulation.deliver_now
  # end

end
