class Service < ApplicationRecord
  belongs_to :city

  extend FriendlyId
  friendly_id :title, use: :slugged
end
