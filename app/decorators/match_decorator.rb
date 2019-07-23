# frozen_string_literal: true

class MatchDecorator < Draper::Decorator
  delegate_all
  decorates_association :game
  decorates_association :player1
  decorates_association :player2

  def player1_info
    h.capture do
      if player1.nil?
        h.concat h.image_tag h.asset_pack_path('images/default_avatar_mini.png')
      else
        h.concat h.image_tag player1.avatar_mini, alt: player1.email, title: player1.email
      end
      h.concat h.tag.span(score1.to_i, class: 'font-weight-bold ml-2 mr-2')
    end
  end

  def player2_info
    h.capture do
      h.concat h.tag.span(score2.to_i, class: 'font-weight-bold ml-2 mr-2')
      if player2.nil?
        h.concat h.image_tag h.asset_pack_path('images/default_avatar_mini.png')
      else
        h.concat h.image_tag player2.avatar_mini, alt: player2.email, title: player2.email
      end
    end
  end

  def start_time
    created_at.to_formatted_s(:long)
  end

  def status
    if in_progress?
      h.tag.span 'in progress'.capitalize, class: 'badge badge-success'
    else
      h.tag.span 'finished'.capitalize, class: 'badge badge-secondary'
    end
  end
end
