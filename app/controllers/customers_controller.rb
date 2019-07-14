class CustomersController < ApplicationController
  def forgot_password; end

  def update_email
    if current_customer.update(email_params)
      redirect_back(fallback_location: root_path, notice: 'Email has been updated')
    else
      redirect_back(fallback_location: root_path, alert: current_customer.errors)
    end
  end

  def update_address
    addresses_forms

    if current_customer.update(billing_address_params) || current_customer.update(shipping_address_params)
      redirect_back(fallback_location: root_path, notice: 'Address has been updated')
    else
      redirect_back(fallback_location: root_path, alert: current_customer.errors)
    end
  end

  def update_password
    if current_customer.update(password_params)
      redirect_back(fallback_location: root_path, notice: 'Password has been updated')
    else
      redirect_back(fallback_location: root_path, alert: current_customer.errors)
    end
  end

  def destroy
    if current_customer.destroy
      redirect_back(fallback_location: root_path, notice: 'Account has been removed')
    else
      redirect_back(fallback_location: root_path, alert: current_customer.errors)
    end
  end

  private

  def addresses_forms
    current_customer.billing_address   || current_customer.billing_address = BillingAddress.new
    current_customer.shipping_address  || current_customer.shipping_address = ShippingAddress.new
  end

  def password_params
    params.require(:customer).permit(:current_password, :password, :password_confirmation)
  end

  def email_params
    params.require(:customer).permit(:email)
  end

  def billing_address_params
    params.require(:customer).permit(billing_address_attributes: Address::FIELDS)
  end

  def shipping_address_params
    params.require(:customer).permit(shipping_address_attributes: Address::FIELDS)
  end
end
