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

    return render 'devise/registrations/fast_new' unless @user.save

    sign_up(:user, @user)
  end
end
