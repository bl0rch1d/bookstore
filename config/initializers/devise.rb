Devise.setup do |config|
  config.mailer_sender = 'support@bookstore.com'

  config.mailer = 'Devise::Mailer'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.send_email_changed_notification = true

  config.send_password_change_notification = true

  config.confirm_within = 1.day

  config.reconfirmable = false

  config.expire_all_remember_me_on_sign_out = true

  config.rememberable_options = { secure: true }

  config.password_length = 8..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.timeout_in = 20.minutes

  config.lock_strategy = :failed_attempts

  config.unlock_keys = [:email]

  config.unlock_strategy = :email

  config.maximum_attempts = 20

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  if Rails.env.production?
    config.omniauth :facebook, Rails.application.credentials.fb_prod[:id],
                    Rails.application.credentials.fb_prod[:secret]
  end

  if Rails.env.development? || Rails.env.test?
    config.omniauth :facebook, Rails.application.credentials.fb_test[:id],
                    Rails.application.credentials.fb_test[:secret]
  end
end
