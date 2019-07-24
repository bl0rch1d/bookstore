source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Rails
gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

# DB
gem 'pg', '~> 1.1'
gem 'sqlite3'

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

# Auth
gem 'devise', '~> 4.6'
# gem 'devise-security', '~> 0.14.3'
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

group :development, :test do
  # Debug
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.12.2'

  # Security
  gem 'brakeman', '~> 4.5'

  # Test bundle
  gem 'capybara', '>= 2.15'
  gem 'rspec', '~> 3.8'
  gem 'rspec-rails', '~> 3.8'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.3'
  gem 'shoulda-matchers', '~> 4.1'
  gem 'simplecov', '~> 0.17.0'

  # Fixtures
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot_rails', '~> 5.0'
  gem 'ffaker', '~> 2.11'

  # Email client emulation
  gem 'letter_opener', '~> 1.7'
  gem 'letter_opener_web', '~> 1.3'

  # Query checkers
  gem 'bullet', '~> 6.0', '>= 6.0.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  # Linters
  gem 'fasterer', '~> 0.5.1'
  gem 'overcommit', '~> 0.22.0'
  gem 'rails_best_practices', '~> 1.19'
  gem 'reek', '~> 5.4'
  gem 'rubocop', '~> 0.72.0'
  gem 'rubocop-i18n', '~> 2.0'
  gem 'rubocop-performance', '~> 1.4'
  gem 'rubocop-rails', '~> 2.2'
  gem 'rubocop-rspec', '~> 1.33'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
