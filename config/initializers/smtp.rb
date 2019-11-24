ActionMailer::Base.smtp_settings = {
  domain: 'sample_domain.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      Rails.application.credentials.smtp[:username],
  password:       Rails.application.credentials.smtp[:password]
}
