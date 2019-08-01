class CouponsController < ApplicationController
  def apply
    result = Coupon::Apply.call(code: params[:code], order: current_order)

    check_result(result)

    redirect_to cart_index_path
  end

  def check_result(result)
    return flash.alert = I18n.t('coupon.errors.not_exist') unless result['model']

    return flash.alert = I18n.t('coupon.errors.expired') unless result['coupon.relevant']

    flash.notice = I18n.t('coupon.applied')
  end
end
