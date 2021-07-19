# frozen_string_literal: true

class TotalComponent < ViewComponent::Base
  def initialize(delivery:)
    @delivery = delivery
  end

  def distance
    (@delivery.distance / 1000.000)
  end

end
