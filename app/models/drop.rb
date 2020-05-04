class Drop < ApplicationRecord
  belongs_to :course


  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
