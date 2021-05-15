class Option < ApplicationRecord
  has_many :user_options, dependent: :destroy
  has_many :delivery_options, dependent: :destroy
  has_many :deliveries, through: :delivery_options

  has_many :city_options, dependent: :destroy
end

# user = User.first
# del = Delivery.new(user: user)
# optn = Option.first
# deloptn = del.delivery_options.new(option: optn, delivery_id: del.id)

# deloptn = DeliveryOption.create(option: optn, delivery_id: del.id)
# del.options = [optn]
# del.delivery_options.create(option: optn, delivery_id: del.id)
# optn.delivery_options.create(delivery_id: del.id)
