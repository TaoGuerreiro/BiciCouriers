class Option < ApplicationRecord
  # has_many :user_options, dependent: :destroy
  # has_many :delivery_options, dependent: :destroy
  # has_many :deliveries, through: :delivery_options

  # has_many :city_options, dependent: :destroy
end
