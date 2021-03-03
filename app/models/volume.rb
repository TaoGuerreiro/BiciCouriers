class Volume < ApplicationRecord
  has_many :user_options, dependent: :destroy
end
