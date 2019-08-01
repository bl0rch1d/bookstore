class FastRegistrationMailer < ApplicationMailer
  def temporary_password(user, password)
    @user = user
    @password = password

    mail(to: @user.email, subject: "Temporary password for #{@user.email}.")
  end
end
