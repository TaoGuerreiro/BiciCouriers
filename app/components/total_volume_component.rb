# frozen_string_literal: true

class TotalVolumeComponent < ViewComponent::Base
  def initialize(volume:)
    @volume = volume
  end
  def volume
    @volume.tickets
  end

  def volume_tickets
    @volume.tickets
  end
end
