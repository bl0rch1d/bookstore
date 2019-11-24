# require 'support/simplecov'

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require "rack_session_access/capybara"
require 'devise'
require 'aasm/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Capybara.default_driver = :selenium_chrome
  Capybara.default_driver = :selenium_chrome_headless

  config.use_transactional_fixtures = true

  config.include OmniAuthTestHelper

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
