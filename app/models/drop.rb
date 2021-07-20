class Drop < ApplicationRecord
  belongs_to :delivery, inverse_of: :drops


  # validates :address, presence: true
  # validates :start_hour, presence: true
  # validates :end_hour, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
