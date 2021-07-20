# frozen_string_literal: true

class DeliveryFormComponent < ViewComponent::Base
  def initialize(delivery:, city:)
    @delivery = delivery
    @city = city
  end

end
