class Course < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :carnet, optional: true
  belongs_to :bike, required: true
  belongs_to :shopping_cart, optional: true

  has_many :drops, dependent: :destroy
  has_many :pickups, dependent: :destroy

  accepts_nested_attributes_for :drops
  accepts_nested_attributes_for :pickups




end
