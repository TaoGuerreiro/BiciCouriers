# frozen_string_literal: true

class TotalUrgenceComponent < ViewComponent::Base
  def initialize(urgence:)
    @urgence = urgence
  end

  def urgence
    @urgence.tickets
  end

  def urgence_tickets
    @urgence.tickets
  end

end
