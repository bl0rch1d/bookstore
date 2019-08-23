class AddressesController < ApplicationController
  include AddressFormsExtractor

  def edit
    result = Address::Update::Present.call(current_user: current_user)

    authorize!(result)

    extract_address_forms(result)
  end

  def update
    result = Address::Update.call(params.merge(current_user: current_user))

    authorize!(result)

    flash.notice = I18n.t('user.notice.address_updated') if result.success?

    extract_address_forms(result)

    render :edit
  end
end
