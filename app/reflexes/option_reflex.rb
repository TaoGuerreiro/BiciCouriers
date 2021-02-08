# frozen_string_literal: true

class OptionReflex < ApplicationReflex
  delegate :current_user, to: :connection

  # DATA = ({
  #   start: 'Nantes',
  #   end: 'Vertou',
  #   urgence: 0,
  #   volume: 0,
  #   distance: 0,
  #   total:0
  # })

  def urgence
    urgence = Urgence.find(element[:value])
    @ticket_urgence = urgence.ticket
    # DATA[:urgence] = @ticket_urgence
    # total()
  end

  def distance
    @start = params[:course][:pickups_attributes]["0"][:address]
    @end = params[:course][:drops_attributes]["0"][:address]
    # DATA[:start] = @start
    # DATA[:end] = @end

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
      # DATA[:distance] = @distance
    rescue NoMethodError
      @distance = 0
      # DATA[:distance] = @distance
    end
    # total()
  end

  # def total
  #   @distance = DATA[:distance]
  #   @urgence = DATA[:urgence]
  # end



end
