class DeliveryOption < ApplicationRecord
  belongs_to :option
  belongs_to :delivery, inverse_of: :delivery_options
end


