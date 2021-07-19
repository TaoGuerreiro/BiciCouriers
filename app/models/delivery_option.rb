class DeliveryOption < ApplicationRecord
  belongs_to :option, inverse_of: :delivery_options
  belongs_to :delivery, inverse_of: :delivery_options
end
