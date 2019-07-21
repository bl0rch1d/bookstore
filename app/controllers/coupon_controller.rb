class CouponsController < ApplicationController
  def apply
    result = Coupon::Apply.call(code: params[:code], order: current_order)

    check_existence(result)
    check_expiration(result)

    redirect_back(fallback_location: root_path, notice: I18n.t('coupon.applied'))
  end

  private

  def check_existence(result)
    return redirect_back(fallback_location: root_path, alert: I18n.t('coupon.errors.not_exist')) unless result['model']
  end

  def check_expiration(result)
    return redirect_back(fallback_location: root_path, alert: I18n.t('coupon.errors.expired')) unless result['coupon.relevant']
  end
end
