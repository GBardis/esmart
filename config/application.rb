require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Esmart
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :minitest, spec: false, fixture: false
    end

    config.autoload_paths += Dir[Rails.root.join('lib')]
  end
end
