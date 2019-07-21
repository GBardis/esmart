class MatchesController < ApplicationController
  include Pundit

  def index
    @matches = policy_scope(Match.select(:player1_id, :player2_id, :score1, :score2, :game_id, :winner_id, :created_at))
               .includes(:winner, player1: [avatar_attachment: :blob], player2: [avatar_attachment: :blob], game: [logo_attachment: :blob])
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
