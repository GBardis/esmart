class AuthToken < ApplicationRecord
  # Associations
  belongs_to :user

  scope :is_active, -> { where(active: true) }
  scope :revoked, -> { where.not(active: false) }

  # validations
  validates :token, uniqueness: true

  def self.revoke_access(user_id)
    AuthToken.update(user_id: user_id, active: false)
  end

  def self.give_access(user_id)
    AuthToken.update(user_id: user_id, active: true)
  end

  def self.create_user_token(user_id, exp = 24.hours.from_now.to_i)
    JsonWebToken.encode(user_id: user_id, exp: exp)
  end
end
