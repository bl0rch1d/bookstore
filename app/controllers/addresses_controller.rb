class AddressesController < ApplicationController
  include AddressFormHelper

  def edit
    result = Address::Update::Present.call(current_user: current_user)

    authorize!(result)

    expose_address_forms(result)
  end

  def update
    result = Address::Update.call(params.merge(current_user: current_user))

    authorize!(result)

    flash.notice = I18n.t('user.notice.address_updated') if result.success?

    expose_address_forms(result)

    render :edit
  end
end
