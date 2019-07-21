class UserDecorator < Draper::Decorator
  delegate_all

  def reputation_badge
    case reputation
    when 7.0..10.0
      h.tag.span 'Good Sport'.capitalize, class: 'badge badge-success'
    when 0.0...7.0
      h.tag.span 'Suspected Cheater'.capitalize, class: 'badge badge-warning'
    else
      h.tag.span 'Reputation Unknown'.capitalize, class: 'badge badge-secondary'
    end
  end

  def avatar_large
    if avatar.attached?
      avatar.variant(combine_options: { thumbnail: '300x300^', extent: '300x300', gravity: 'center' })
    else
      h.asset_pack_path('images/default_avatar.png')
    end
  end

  def avatar_mini
    if avatar.attached?
      avatar.variant(combine_options: { thumbnail: '50x50^', extent: '50x50', gravity: 'center' })
    else
      h.asset_pack_path('images/default_avatar_mini.png')
    end
  end
end
