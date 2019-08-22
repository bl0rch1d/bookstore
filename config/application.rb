require_relative 'boot'

require 'rails/all'
require_relative '../lib/trailblazer_executor/trailblazer_executor'

Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    config.load_defaults 5.2

    config.eager_load_paths << Rails.root.join('lib')

    config.generators do |generator|
      generator.test_framework :rspec
      generator.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.action_dispatch.signed_cookie_digest = 'SHA256'

    config.session_store :cache_store, key: "_#{Rails.application.class.parent_name.downcase}_session"
  end
end
