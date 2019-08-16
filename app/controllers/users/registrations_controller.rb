class Users::RegistrationsController < Devise::RegistrationsController
  def fast_new
    @user = User.new
  end

  def fast_create
    result = FastUser::Create.call(
      email: user_params[:email],
      password: Devise.friendly_token.first(Devise.password_length.first)
    )

    if result.success?
      sign_up(:user, result['model'])
    else
      flash.alert = contract_errors(result)
      redirect_to users_fast_new_path
    end
  end

  protected

  def update_resource(resource, params)
    user_params[:current_password] ? super : resource.update_without_password(user_params)
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def user_params
    params.require(:user).permit(:email, :current_password)
  end
end
