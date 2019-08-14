class FastRegistrationMailer < ApplicationMailer
  def temporary_password(user_id, password)
    @user = User.find_by(id: user_id)
    @password = password

    mail(
      to: @user.email,
      subject: I18n.t('user.mailer.subject', user_email: @user.email)
    )
  end
end
