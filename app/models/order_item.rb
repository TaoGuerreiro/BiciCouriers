class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :delivery
  belongs_to :tikets_book

  # after_save :create_new_cart, on: :update


  private

  # def create_new_cart
  #   ShoppingCart.create(
  #     {
  #       user_id: self.id
  #     }
  #   )
  # end

end
