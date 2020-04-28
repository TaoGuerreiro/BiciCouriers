class CarnetTemplate < ApplicationRecord
  has_many :carnets

  monetize :price_cents
end
