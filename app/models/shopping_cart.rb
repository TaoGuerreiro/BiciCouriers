class ShoppingCart < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :carnets, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :user

  monetize :price_cents

end
