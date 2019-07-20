# frozen_string_literal: true

class Game < ApplicationRecord
  # Associations
  has_many :gamer_profiles
  has_many :users, through: :gamer_profiles, dependent: :destroy
  has_many :matches

  has_one_attached :logo

  has_one :logo_attachment, -> { where(name: 'logo') }, class_name: 'ActiveStorage::Attachment', as: :record, inverse_of: :record, dependent: false
  has_one :logo_blob, through: :image_attachment, class_name: 'ActiveStorage::Blob', source: :blob

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  # Scopes
  scope :enabled, -> { where(enabled: true) }
end
