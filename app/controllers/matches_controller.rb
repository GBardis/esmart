class MatchesController < ApplicationController
  include Pundit

  def index
    @matches = policy_scope(Match.select(:player1_id, :player2_id, :score1, :score2, :game_id, :winner_id, :created_at))
               .includes(:winner, player1: [avatar_attachment: :blob], player2: [avatar_attachment: :blob], game: [logo_attachment: :blob])
               .order(created_at: :desc)
               .decorate
  end

  def new
    # TODO
  end

  def create
    # TODO
  end

  private
end
