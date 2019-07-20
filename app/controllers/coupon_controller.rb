class CouponsController < ApplicationController
  def apply
    result = Coupon::Apply.call(code: params[:code], order: current_order)

    return redirect_back(fallback_location: root_path, alert: I18n.t('coupon.errors.not_exist')) unless result['model']

    return redirect_back(fallback_location: root_path, alert: I18n.t('coupon.errors.expired')) unless result['coupon.relevant']

    redirect_back(fallback_location: root_path, notice: I18n.t('coupon.applied'))
  end
end
