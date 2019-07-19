class GameDecorator < Draper::Decorator
  delegate_all

  def logo_mini
    if logo.attached?
      logo.variant(resize: '100x75')
    else
      h.asset_pack_path('images/default_logo_mini.png')
    end
  end

end
