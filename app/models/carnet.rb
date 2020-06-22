class Carnet < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :carnet_template, required: true
  has_many :courses, dependent: :destroy
  belongs_to :shopping_cart, optional: true

  scope :finished, -> { where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid') }

end
