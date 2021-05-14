class Option < ApplicationRecord
  has_many :user_options, dependent: :destroy
  has_many :delivery_options, dependent: :destroy
  has_many :deliveries, through: :delivery_options

  has_many :city_options, dependent: :destroy
end

# user = User.first
# del = Delivery.create
# optn = Option.first
# deloptn = DeliveryOption.create(option: optn, delivery_id: del.id)
# del.options = [optn]