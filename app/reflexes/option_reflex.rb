# frozen_string_literal: true

class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection

  # after_reflex :total

  def urgence
    urgence = Urgence.find(element[:value])
    morph "#urgence-ticket-nb", urgence.ticket

    morph "#testmorph", element[:checked]

  def volume
    volume = Volume.find(element[:value])
    morph "#volume-ticket-nb", volume.ticket
  end

  def distance
    start_address = params[:course][:pickups_attributes]["0"][:address]
    end_address = params[:course][:drops_attributes]["0"][:address]

    begin
      url = 'https://maps.googleapis.com/maps/api/directions/json?'
      query = {
        origin: start_address,
        destination: end_address,
        key: ENV['GOOGLE_API_KEY']
      }

      distance = JSON.parse(HTTParty.get(
        url,
        query: query
      ).body)

      distance = (distance['routes'][0]['legs'][0]['distance']['value']) / 1000.000
      distance_ticket = (distance / 3.5).ceil

      morph "#distance-ticket-nb", distance_ticket
      morph "#distance-km-nb", distance

    rescue NoMethodError
      # distance = "Je calcul..."
     end
  end

  private

  def total
    test = params
    morph "#testmorph", test
  end

end
