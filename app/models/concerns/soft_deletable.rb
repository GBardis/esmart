# frozen_string_literal: true

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deleted_at: nil) }
    scope :deleted, -> { where.not(deleted_at: nil) }
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
