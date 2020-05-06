module ApplicationHelper

  def state_translation(pg_state)
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
