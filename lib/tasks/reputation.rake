namespace :reputation do
  desc 'Recheck reputation for all users'
  task recheck: :environment do
    User.pluck(:email).each { |email| ReputationWorker.perform_async(email) }
  end
end
