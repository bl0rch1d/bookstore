if ENV['REDIS_URL']
  Bookstore::Application.config.session_store :redis_store,
    servers: ["#{ENV['REDIS_URL']}/0/session"],
    expire_after: 90.minutes,
    key: "_#{Rails.application.class.parent_name.downcase}_session",
    threadsafe: false
end