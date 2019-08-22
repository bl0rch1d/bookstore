class AddressesController < ApplicationController
  include AddressFormsExtractor

  execute_and_authorize_operation

  def edit
    extract_address_forms(@operation_result)
  end

  def update
    flash.notice = I18n.t('user.notice.address_updated') if @operation_result.success?

    extract_address_forms(@operation_result)

    render :edit
  end
end
