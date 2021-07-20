class Urgence < ApplicationRecord
    has_many :delivery, inverse_of: :urgence
end
