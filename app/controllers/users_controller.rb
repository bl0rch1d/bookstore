class UsersController < ApplicationController
  before_action :authenticate_user!

  # === TODO: More suitable routes ===
  def index
    result = Address::Update::Present.call('current_user' => current_user)

    expose_address_forms(result)
  end

  def update_email
    if current_user.update(email_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.email_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors)
    end
  end

  # === TODO: Refactor ===
  def update_address
    result = Address::Update.call(params.merge('current_user' => current_user))

    if result.success?
      # flash.notice = I18n.t('user.notice.addresses_updated')
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.addresses_updated'))
    else
      expose_address_forms(result)

      form = @billing_address_form || @shipping_address_form

      redirect_back(fallback_location: root_path, alert: form.errors.full_messages)
    end

    # render 'users/index'
  end

  def update_password
    if current_user.update_with_password(password_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.password_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors)
    end
  end

  def destroy
    if current_user.destroy
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.account_removed'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors)
    end
  end

  private
  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def email_params
    params.require(:user).permit(:email)
  end
end
