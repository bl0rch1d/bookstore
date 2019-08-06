class AddressesController < ApplicationController
  before_action :authenticate_user!

  def edit
    result = Address::Update::Present.call('current_user' => current_user)

    expose_address_forms(result)
  end

  def update
    result = Address::Update.call(params.merge('current_user' => current_user))

    flash.notice = I18n.t('user.notice.address_updated') if result.success?

    expose_address_forms(result)

    render :edit
  end
end
