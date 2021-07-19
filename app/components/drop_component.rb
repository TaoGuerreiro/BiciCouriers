# frozen_string_literal: true

class DropComponent < ViewComponent::Base
  def initialize(drops:, field:, city:)
    @drops = drops
    @field = field
    @city = city
  end

end
