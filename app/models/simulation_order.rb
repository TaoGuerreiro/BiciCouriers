class SimulationOrder < ApplicationRecord
  belongs_to :simulation

  monetize :amount_cents
end
