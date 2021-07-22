# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = prepare_data(data)
    @icon_class = icon_class
    @icon_color_class = icon_color_class

    @data[:timeout] ||= 3
  end

  private

  def icon_class
    case @type
    when 'success'
      'fa-check-square'
    when 'error'
      'fa-exclamation-square'
    when 'alert'
      'fa-exclamation-square'
    else
      'fa-info-square'
    end
  end

  def icon_color_class
    case @type
    when 'success'
      'text-green-400'
    when 'error'
      'text-red-800'
    when 'alert'
      'text-red-400'
    else
      'text-gray-400'
    end
  end

  def prepare_data(data)
    case data
    when Hash
      data
    else
      { title: data }
    end
  end
end
