# frozen_string_literal: true

class TotalComponent < ViewComponent::Base
  def initialize(delivery:, urgence:, volume:)
    @delivery = delivery
    @urgence = urgence
    @volume = volume
  end

  def distance
    (@delivery.distance / 1000.000)
  end

end
