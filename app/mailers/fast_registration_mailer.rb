class FastRegistrationMailer < ApplicationMailer
  def temporary_password(user, password)
    @user = user
    @password = password

    mail(to: @user.email, subject: I18n.t('user.mailer.subject', user_email: @user.email))
  end
end
