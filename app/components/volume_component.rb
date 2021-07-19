# frozen_string_literal: true

class VolumeComponent < ViewComponent::Base
  def initialize(delivery_options:, field:)
    @delivery_options = delivery_options
    @field = field
  end

end
