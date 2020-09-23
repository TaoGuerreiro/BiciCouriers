class Bike < ApplicationRecord
  has_many :courses, dependent: :destroy
end
