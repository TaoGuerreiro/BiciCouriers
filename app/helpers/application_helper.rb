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
end
