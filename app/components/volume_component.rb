# frozen_string_literal: true

class VolumeComponent < ViewComponent::Base
  def initialize(delivery_options:, field:, volume:)
    @delivery_options = delivery_options
    @field = field
    @volume = volume
  end

end
