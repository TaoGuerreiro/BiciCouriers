# frozen_string_literal: true

class PickupComponent < ViewComponent::Base
  def initialize(pickups:, field:, city:)
    @pickups = pickups
    @field = field
    @city = city
  end

end
