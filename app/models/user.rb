class User < ApplicationRecord
  include SoftDeletable
  include RemovableFile

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_removable_file :avatar

  # Associations
  has_many :gamer_profiles, dependent: :destroy
  has_many :games, -> { order(:title) }, through: :gamer_profiles, dependent: :destroy
  has_many :matches_played, ->(object) { unscope(:where).where('player1_id = :player_id OR player2_id = :player_id', player_id: object.id) }, class_name: 'Match'
  has_many :matches_won, class_name: 'Match', foreign_key: :winner_id

  has_one_attached :avatar

  has_one :avatar_attachment, -> { where(name: 'avatar') }, class_name: 'ActiveStorage::Attachment', as: :record, inverse_of: :record, dependent: false
  has_one :avatar_blob, through: :image_attachment, class_name: 'ActiveStorage::Blob', source: :blob

  # Validations
  validates :reputation, numericality: true, allow_nil: true

  # Callbacks
  after_commit :fetch_reputation, on: :create

  def cheater?
    reputation && reputation < 7.0
  end

  def active_for_authentication?
    super && !deleted_at
  end

  private

  def fetch_reputation
    ::ReputationWorker.perform_async(email)
  end
end
