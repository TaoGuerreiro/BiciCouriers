class TicketsBook < ApplicationRecord
  belongs_to :books_template, required: true
  belongs_to :user, required: true

  has_many :order_items, as: :orderable

  has_many :delivery_books
  has_many :deliveries, through: :delivery_books


  # scope :finished, -> { where('remaining_tickets > ? AND shopping_carts.state = ?', 0, 'paid') }

end
