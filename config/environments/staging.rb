Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.public_file_server.headers = {
    'Cache-Control' => 'public, s-maxage=31536000, maxage=31536000',
    'Expires' => 1.year.from_now.to_formatted_s(:rfc822).to_s
  }

  config.assets.js_compressor = Uglifier.new(harmony: true)

  config.assets.compile = false

  config.active_storage.service = :amazon

  # config.force_ssl = true

  config.log_level = :debug

  config.log_tags = [:request_id]

  config.cache_store = :redis_cache_store, { url: "#{ENV['REDIS_URL']}/0" }

  config.active_job.queue_adapter = :sidekiq

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'https://bookstore-diz.herokuapp.com/' }
  config.action_mailer.perform_deliveries = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end

