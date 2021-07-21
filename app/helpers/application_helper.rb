module ApplicationHelper

  def state_translation(pg_state, course)
    if course.carnet.present?
      case pg_state
        when 'pending'
          'En attente'
        when 'inprogress'
          'En livraison'
        when 'accepted'
          'Accepté'
        when 'done'
          'Livré'
      end
    else
      if course.shopping_cart.state == 'pending'
        'Reglement en attente'
      else
        case pg_state
          when 'pending'
            'En attente'
          when 'inprogress'
            'En livraison'
          when 'accepted'
            'Accepté'
          when 'done'
            'Livré'
        end
      end
    end
  end

  def state_order_translation(pg_state)
    case pg_state
      when 'pending'
        'Reglement en attente'
      when 'paid'
        'rélgée'
    end
  end

  def state_urgence_translation(nb)
    case nb
      when 0
        'Dans la journée'
      when 1
        'Sous 4 heures'
      when 2
        'Sous 45 minutes'
    end
  end

  def hour_to_dec(time)

    hour = '%02d' % time.hour
    dec = (time.hour/6) * 10

    return `#{hour},#{dec}`.to_f.round(2)

  end

  def next_availible_delivery_time(urgence, city)

    choosen_city_option_rank = urgence.city_options.find_by( option_id: urgence).rank # les urgence n'on pas de rank obviously !!!! Et les delivery_options non plus, idiot.
    choosen_city_option_max_value = urgence.max_value.second

    previous_city_option = CityOption.find_by(rank: (choosen_city_option_rank + 1)) || urgence.city_options.find_by( option_id: urgence)
    previous_city_option_max_value = previous_city_option.option.max_value.second

    heure_start, min_start = city.start_hour.split(':').map(&:to_i)
    heure_end, min_end = city.end_hour.split(':').map(&:to_i)
    today_start = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_start, min_start).utc
    today_end = DateTime.new(Time.now.year, Time.now.month, Time.now.day, heure_end, min_end).utc
    now = Time.now.utc
    # delivery_limit = now + max_value

    case
      when choosen_city_option_rank == 1 #urgence 1 est toujoursdans la journée,
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      when now < today_start
        result = today_start + choosen_city_option_max_value
      when choosen_city_option_rank == 2
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      when choosen_city_option_rank == 3
        if (today_end - choosen_city_option_max_value) > now
          result = now + choosen_city_option_max_value
        elsif (today_end - previous_city_option_max_value) > now
          result = today_end
        elsif (today_end - previous_city_option_max_value) < now
          result = today_start + 1.day + choosen_city_option_max_value
        end

      else
        result = now + max_value
    end
    return result
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
      end_hour = today_start + urgence.range
      start_hour = today_start
    else
      if (now + urgence.range) <= today_end                   # Si je depasse la fin de journée                     => now + range
        end_hour = now + urgence.range
        start_hour = now
      else (now + urgence.range) > today_end                 # Si je depasse la fin de journée                     =

        next_urgence =      Urgence.includes(:city_urgences).where(city_urgences: {rank: (urgence.rank +1), city_id: city.id}).first
        over_next_urgence = Urgence.includes(:city_urgences).where(city_urgences: {rank: (urgence.rank +2), city_id: city.id}).first

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
    # binding.pry
    return [start_hour, end_hour]
  end
end
