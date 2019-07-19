class DashboardsController < ApplicationController

  def show
    @current_matches = Match.in_progress.order(created_at: :desc).limit(3).decorate
    @matches_played = current_user.matches_played.finished.includes(:game).decorate
  end

end