# frozen_string_literal: true

class TotalComponent < ViewComponent::Base
  def initialize(delivery:, city:)
    @delivery = delivery
    @city = city
  end

  def hidden_if_zero(tickets)
    "hidden" if tickets == 0
  end
  #TOTAL
  def total_tickets
    @delivery.tickets_distance + @delivery.urgence.tickets + @delivery.volume.tickets
  end
  def total_price
    number_to_currency(((@delivery.tickets_distance +
      @delivery.urgence.tickets +
      @delivery.volume.tickets) *
      @city.base_ticket_price), unit: "€")
  end

  #DISPLAY
  def distance_display
    (@delivery.distance / 1000.000)
  end

  def urgence_display
    @delivery.urgence.name
  end

  def volume_display
    @delivery.volume.name
  end

  #TICKETS
  def distance_tickets
    @delivery.tickets_distance
  end

  def urgence_tickets
    @delivery.urgence.tickets
  end

  def volume_tickets
    @delivery.volume.tickets
  end

  #€€€€

  def distance_price
    number_to_currency((@delivery.tickets_distance * @city.base_ticket_price), unit: "€")
  end

  def urgence_price
    number_to_currency((@delivery.urgence.tickets * @city.base_ticket_price), unit: "€")
  end

  def volume_price
    number_to_currency((@delivery.volume.tickets * @city.base_ticket_price), unit: "€")
  end
end
