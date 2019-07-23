# frozen_string_literal: true

class Match < ApplicationRecord
  # Associations
  belongs_to :game
  belongs_to :player1, class_name: 'User'
  belongs_to :player2, class_name: 'User'
  belongs_to :winner, class_name: 'User'

  # Validations
  validates :player1, presence: true
  validates :player2, presence: true
  validates :score1, numericality: true, allow_nil: true
  validates :score2, numericality: true, allow_nil: true
  validate :distinct_players

  # Scopes
  scope :finished, -> { where.not(winner: nil) }
  scope :in_progress, -> { where(winner: nil) }

  def set_winner(user)
    update(winner: user)
  end

  def finished?
    winner.present?
  end

  def in_progress?
    !finished?
  end

  private

  def distinct_players
    errors.add(:base, :duplicate_players) if player1 == player2
  end
end
