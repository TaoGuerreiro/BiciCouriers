# frozen_string_literal: true

class DeliveryFormComponent < ViewComponent::Base
  def initialize(delivery:, city:)
    @delivery = delivery
    @city = city
  end

  def start_hour
    max_hours(@city, @delivery.urgence).first.strftime("%H:%M")
  end
  def end_hour
    max_hours(@city, @delivery.urgence).last.strftime("%H:%M")
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
