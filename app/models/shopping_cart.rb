class ShoppingCart < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :carnets, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :user

  monetize :price_cents

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
