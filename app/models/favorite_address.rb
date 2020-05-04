class FavoriteAddress < ApplicationRecord
  belongs_to :user


  validates :title, presence: true
  validates :address, presence: true

end
