class City < ApplicationRecord
  has_many :avantages
  has_many :contacts
  has_many :services
  has_many :city_options

end
