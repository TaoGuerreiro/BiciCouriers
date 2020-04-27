class FavoriteAddress < ApplicationRecord
  belongs_to :user
  has_many :drops
  has_many :pickups

  validates :title, presence: true
  validates :address, presence: true

end
