class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    addresses_forms
  end

  def update_email
    if current_user.update(email_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.email_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors)
    end
  end

  def update_address
    addresses_forms

    if current_user.update(billing_address_params) || current_user.update(shipping_address_params)
      redirect_back(fallback_location: root_path, notice: I18n.t('user.notice.addresses_updated'))
    else
      redirect_back(fallback_location: root_path, alert: current_user.errors)
    end
  end

  def update_password
    if current_user.update(password_params)
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

  def addresses_forms
    current_user.billing_address   || current_user.billing_address = BillingAddress.new
    current_user.shipping_address  || current_user.shipping_address = ShippingAddress.new
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def email_params
    params.require(:user).permit(:email)
  end

  def billing_address_params
    params.require(:user).permit(billing_address_attributes: Address::FIELDS)
  end

  def shipping_address_params
    params.require(:user).permit(shipping_address_attributes: Address::FIELDS)
  end
end
