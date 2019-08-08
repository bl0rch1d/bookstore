require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')

    config.generators do |generator|
      generator.test_framework :rspec
      generator.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.action_dispatch.signed_cookie_digest = 'SHA256'

    config.session_store :cache_store, key: "_#{Rails.application.class.parent_name.downcase}_session"
  end
end
