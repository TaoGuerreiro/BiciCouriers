# frozen_string_literal: true

class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def urgence
    urgence = Urgence.find(element[:value])

    @ticket_urgence = urgence.ticket

  end

  def distance
    @start = params[:course][:pickups_attributes]["0"][:address]
    @end = params[:course][:drops_attributes]["0"][:address]

    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: @start,
        destination: @end,
        key: ENV['GOOGLE_API_KEY']
      }

      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)

      @distance = (distance['routes'][0]['legs'][0]['distance']['value']) / 1000.000
    rescue NoMethodError
      @distance = 0
    end
  end

end
