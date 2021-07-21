class Volume < ApplicationRecord
    has_many :delivery, inverse_of: :volume
    has_many :city_volumes, inverse_of: :volume
end
