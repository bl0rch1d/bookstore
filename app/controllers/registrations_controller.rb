class RegistrationsController < Devise::RegistrationsController
  def fast_new
    @user = User.new
  end

  def fast_create
    generated_password = Devise.friendly_token.first(8)

    @user = User.new(
      email: params[:user][:email],
      password: generated_password,
      password_confirmation: generated_password
    )

    if @user.save
      FastRegistrationMailer.with(user: @user, password: generated_password)
                            .temp_password_info.deliver_later

      sign_up(:user, @user)
    else
      render 'devise/registrations/fast_new'
    end
  end
end
