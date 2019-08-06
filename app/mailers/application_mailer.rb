class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('store.email')
  layout 'mailer'
end
