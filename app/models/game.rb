# frozen_string_literal: true

class Game < ApplicationRecord
  # Associations
  has_many :gamer_profiles, dependent: :destroy
  has_many :users, through: :gamer_profiles, dependent: :destroy
  has_many :matches

  has_one_attached :logo

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Scopes
  scope :enabled, -> { where(enabled: true) }
end
