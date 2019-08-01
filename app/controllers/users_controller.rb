class UsersController < ApplicationController
  before_action :authenticate_user!

  def addresses
    result = Address::Update::Present.call('current_user' => current_user)

    expose_address_forms(result)
  end

  def update_address
    result = Address::Update.call(params.merge('current_user' => current_user))

    flash.notice = I18n.t('user.notice.addresses_updated') if result.success?

    expose_address_forms(result)

    render 'users/addresses'
  end

  def privacy; end

  def update_email
    if current_user.update(email_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.email_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors.full_messages)
    end
  end

  def update_password
    if current_user.update_with_password(password_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.password_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors.full_messages)
    end
  end

  def destroy
    if current_user.destroy
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.account_removed'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors.full_messages)
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
