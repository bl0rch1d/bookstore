class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication

      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      failed_login
    end
  end

  def failure
    redirect_to(root_path, alert: I18n.t('notices.facebook.error'))
  end

  private

  def failed_login
    session['devise.facebook_data'] = request.env['omniauth.auth']
    redirect_to(new_user_registration_url, alert: I18n.t('notices.facebook.error_authentication'))
  end
end
