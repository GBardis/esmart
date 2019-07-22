class MatchesController < ApplicationController
  include Pundit

  def index
    @matches = policy_scope(Match)
               .includes(:game, :player1, :player2)
               .order(created_at: :desc)
               .decorate
  end

  def new
    @match = Match.new
    @current_user_games = current_user.games
    @gamer_profiles = GamerProfile.all
    @users = User.where.not(id: current_user.id)
  end

  def create
    @match = Match.new(match_params)
    @match.player1_id = current_user.id
    @match.winner_id = [@match.player1_id, @match.player2_id].sample
    if @match.save
      redirect_to matches_path
    else
      redirect_to matches_new_path
    end
  end

  private

  def match_params
    params.permit(:game_id, :player2_id)
  end
end
