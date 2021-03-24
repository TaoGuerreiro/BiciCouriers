class BookTemplate < ApplicationRecord
  has_many :tickets_books

  monetize :price_cents
end
