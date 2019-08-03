require 'database_cleaner'

RSpec.configure do |config|
  config.before(:all) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    FileUtils.rm_rf(Rails.root.join('tmp', 'storage'))
  end
end
