class AddressesController < ApplicationController
  include AddressFormsExtractor

  def edit
    result = Address::Edit.call(current_user: current_user)

    authorize!(result)

    extract_address_forms(result)
  end

  def update
    result = define_type_and_call_operation

    authorize!(result)

    flash.notice = I18n.t('user.notice.address_updated') if result.success?

    extract_address_forms(result)

    render :edit
  end

  private

  def define_type_and_call_operation
    operation_params = params.merge(current_user: current_user)

    return Address::Billing::Update.call(operation_params) if params.dig(:user, :billing_address_attributes)

    Address::Shipping::Update.call(operation_params)
  end
end
