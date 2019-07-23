# frozen_string_literal: true

class MatchesController < ApplicationController
  include Pundit

  def index
    @matches = policy_scope(Match)
               .includes(:game, :player1, :player2)
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
