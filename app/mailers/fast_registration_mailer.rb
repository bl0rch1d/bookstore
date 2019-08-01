class FastRegistrationMailer < ApplicationMailer
  def temp_password_info
    @user = params[:user]
    @password = params[:password]

    mail(to: @user.email, subject: 'Fast registration random password')
  end
end
