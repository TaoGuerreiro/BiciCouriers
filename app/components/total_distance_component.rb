# frozen_string_literal: true

class TotalDistanceComponent < ViewComponent::Base
  def initialize(delivery:)
    @delivery = delivery
  end

  def distance
    (@delivery.distance / 1000.000)
  end

  def distance_tickets
    @delivery.tickets_distance || 0
  end

end
