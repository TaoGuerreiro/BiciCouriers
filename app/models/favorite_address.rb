class FavoriteAddress < ApplicationRecord
  belongs_to :user, dependent: :destroy


  validates :title, presence: true
  validates :address, presence: true

end
