class ReputationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(email)
    user = User.find_by(email: email)
    user.reputation = ReputationFetcher.fetch(email)
    user.save if user.reputation_changed?
  end
end
