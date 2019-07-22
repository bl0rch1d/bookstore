class RegistrationsController < Devise::RegistrationsController
  def fast_new
    @user = User.new
  end

  # === TODO: Email confirmation with generated password ===

  def fast_create
    generated_password = Devise.friendly_token.first(8)

    @user = User.new(email: params[:user][:email], password: generated_password)

    if @user.save
      sign_up(:user, @user)

      redirect_to checkout_path(:address)
    else
      render 'devise/registrations/fast_new'
    end
  end
end
