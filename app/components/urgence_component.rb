# frozen_string_literal: true

class UrgenceComponent < ViewComponent::Base
  def initialize(delivery_options:, field:, urgence:)
    @delivery_options = delivery_options
    @field = field
    @urgence = urgence
  end

end
