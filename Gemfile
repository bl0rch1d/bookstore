source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Rails
gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'rails-html-sanitizer', '~> 1.0.3'

# DB
gem 'hiredis', '~> 0.6.3'
gem 'pg', '~> 1.1'
gem 'redis', '~> 4.1'

# JS/CSS
gem 'bootstrap-sass', '~> 3.4'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails', '~> 4.7'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Forms
gem 'country_select', '~> 4.0'
gem 'simple_form', '~> 4.1'

# Authentication
gem 'devise', '~> 4.6'
gem 'omniauth-facebook', '~> 5.0'

# Admin panel
gem 'activeadmin', '~> 2.1'

# Pagination
gem 'pagy', '~> 3.3'

# State machines
gem 'aasm', '~> 5.0'
gem 'wicked', '~> 1.3'

# Decoration helpers
gem 'draper', '~> 3.1'

# Template Engine
gem 'haml', '~> 5.1'

# Image processing
gem 'image_processing', '~> 1.9'
gem 'mini_magick', '~> 4.9'

# Trailblazer bundle
gem 'reform', '~> 2.2'
gem 'reform-rails', '~> 0.1.7'
gem 'trailblazer', '~> 2.0'
gem 'trailblazer-rails', '~> 1.0'

# Fake data
gem 'ffaker', '~> 2.11'

# Email client emulation
gem 'letter_opener', '~> 1.7'
gem 'letter_opener_web', '~> 1.3'

# BG job processing
gem 'sidekiq', '~> 5.2', '>= 5.2.7'

# Cloud storage
gem 'aws-sdk-s3', '~> 1.46', require: false

# API
gem 'rest-client', '~> 2.0', '>= 2.0.2'

group :development, :test do
  # Debug
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.12.2'

  # Test bundle
  gem 'capybara', '>= 2.15'
  gem 'rack_session_access', '~> 0.2.0'
  gem 'rspec', '~> 3.8'
  gem 'rspec-rails', '~> 3.8'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.3'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', '~> 0.17.0'

  # Fixtures
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 5.0'

  # Query checker
  gem 'bullet', '~> 6.0', '>= 6.0.1'

  # Profiler
  gem 'flamegraph', '~> 0.9.5'
  gem 'stackprof', '~> 0.2.12'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  # Security
  gem 'brakeman', '~> 4.5'
  gem 'bundler-audit', '~> 0.6.1'

  # Linters
  gem 'fasterer', '~> 0.5.1'
  gem 'haml_lint', '~> 0.32.0'
  gem 'overcommit', '~> 0.49.0'
  gem 'rails_best_practices', '~> 1.19'
  gem 'rubocop', '~> 0.72.0'
  gem 'rubocop-i18n', '~> 2.0'
  gem 'rubocop-performance', '~> 1.4'
  gem 'rubocop-rails', '~> 2.2'
  gem 'rubocop-rspec', '~> 1.33'

  # Code quality reporter
  gem 'rubycritic', '~> 4.1', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
