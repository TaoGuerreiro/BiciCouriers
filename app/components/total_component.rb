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
    "#{(@delivery.tickets_distance + @delivery.urgence.tickets + @delivery.volume.tickets)} t"
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
    if start_date == "aujourd'hui"
      if start_date == end_date
        "Livraison #{start_date} entre #{start_hour} et #{end_hour}"
      else
        "Livraison #{start_date} entre #{start_hour} et #{end_date} à #{end_hour}"
      end
    else
      "Livraison #{start_date} entre #{start_hour} et #{end_hour}"
    end
  end

  def volume_display
    @delivery.volume.name
  end

  #TICKETS
  def distance_tickets
    @delivery.tickets_distance
    "#{@delivery.tickets_distance} t"
  end

  def urgence_tickets
    @delivery.urgence.tickets
    "#{@delivery.urgence.tickets} t"
  end

  def volume_tickets
    @delivery.volume.tickets
    "#{@delivery.volume.tickets} t"
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

  private

  #HELPER
  def start_hour
    max_hours(@city, @delivery.urgence).first.strftime("%H:%M")
  end
  def end_hour
    max_hours(@city, @delivery.urgence).last.strftime("%H:%M")
  end

  def start_date
    if max_hours(@city, @delivery.urgence)
      "aujourd'hui"
    else
      "demain"
    end
  end

  def end_date
    if max_hours(@city, @delivery.urgence).last.today?
      "aujourd'hui"
    else
      "demain"
    end
  end

  def max_hours(city, urgence)
    heure_start, min_start = city.start_hour.split(':').map(&:to_i)
    heure_end, min_end = city.end_hour.split(':').map(&:to_i)
    today_start = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_start, min_start).utc
    today_end = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_end, min_end).utc
    now = Time.now.utc

    if today_start > now
      end_hour = today_start + urgence.range
      start_hour = today_start
    elsif today_end < now
      end_hour = today_start + 1.day + urgence.range
      start_hour = today_start + 1.day
    else
      if (now + urgence.range) <= today_end                   # Si je depasse la fin de journée                     => now + range
        end_hour = now + urgence.range
        start_hour = now
      else (now + urgence.range) > today_end                 # Si je depasse la fin de journée                     =


        next_urgence =      Urgence.includes(:city_urgences).where(city_urgences: {rank: (urgence.city_urgences.first.rank + 1 ), city_id: city.id}).first
        over_next_urgence = Urgence.includes(:city_urgences).where(city_urgences: {rank: (urgence.city_urgences.first.rank + 2 ), city_id: city.id}).first

        if over_next_urgence.nil?
          if next_urgence.nil?
            end_hour = today_start + 1.day + urgence.range
            start_hour = now
          else
            if(now + next_urgence.range) < today_end             # Et que je suis pas encore dans la prochaine urgence
              end_hour = today_end
              start_hour = now
            else
              if over_next_urgence.nil?
                end_hour = today_start + 1.day + urgence.range
                start_hour = now
              else
                if(now + over_next_urgence.range) > today_end             # Et que je suis pas encore dans la prochaine urgence
                  end_hour = today_start + 1.day + urgence.range
                  start_hour = now
                elsif (now + next_urgence.range) < today_end             # Et que je suis pas encore dans la prochaine urgence
                  end_hour = today_end                                # Alors                                               => fin de journée
                  start_hour = now
                else
                  end_hour = today_start + 1.day + next_urgence.range #                                                     => lendemain + prochaine urgence
                  start_hour = now
                end
              end
            end
          end
        elsif (now + next_urgence.range) < today_end             # Et que je suis pas encore dans la prochaine urgence
          end_hour = today_end
          start_hour = now
        else
          if over_next_urgence.nil?
            end_hour = today_start + 1.day + urgence.range
            start_hour = now
          else
            if(now + over_next_urgence.range) > today_end             # Et que je suis pas encore dans la prochaine urgence
              end_hour = today_start + 1.day + urgence.range
              start_hour = now
            elsif (now + next_urgence.range) < today_end             # Et que je suis pas encore dans la prochaine urgence
              end_hour = today_end                                # Alors                                               => fin de journée
              start_hour = now
            else
              end_hour = today_start + 1.day + next_urgence.range #                                                     => lendemain + prochaine urgence
              start_hour = now
            end
          end
        end
      end
    end
    return [start_hour, end_hour]
  end
end
