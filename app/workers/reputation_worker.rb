# frozen_string_literal: true

class ReputationWorker
  include Sidekiq::Worker

  def perform(email)
    user = User.find_by(email: email)
    user.reputation = ReputationFetcher.fetch(email)
    user.save if user.reputation_changed?
  end
end
