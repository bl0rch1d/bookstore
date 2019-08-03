class Users::RegistrationsController < Devise::RegistrationsController
  def fast_new
    @user = User.new
  end

  def fast_create
    result = User::Create.call(email: params[:user][:email], password: Devise.friendly_token.first(8))

    if result.success?
      sign_up(:user, result['model'])
    else
      flash.alert = result['contract.default'].errors.full_messages
      redirect_to users_fast_new_path
    end
  end

  protected

  def update_resource(resource, params)
    user_params[:current_password] ? super : resource.update_without_password(user_params)
  end

  def after_update_path_for(_resource)
    request.referer.presence ? request.referer : root_path
  end

  def user_params
    params.require(:user).permit(:email, :current_password)
  end
end