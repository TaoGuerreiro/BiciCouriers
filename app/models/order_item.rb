class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :delivery
  belongs_to :tikets_book

  belongs_to :orderable, polymorphic: true

  # after_save :create_new_cart, on: :update

end
