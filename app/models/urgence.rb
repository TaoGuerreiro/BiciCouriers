class Urgence < ApplicationRecord
    has_many :delivery, inverse_of: :urgence
    has_many :city_urgences, inverse_of: :urgence
end
