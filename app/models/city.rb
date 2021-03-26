class City < ApplicationRecord
  has_many :avantages, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :city_options, dependent: :destroy

end
