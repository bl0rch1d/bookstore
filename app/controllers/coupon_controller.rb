class CouponController < ApplicationController
  def apply
    result = Coupon::Apply.call(code: params[:code], order: current_order)

    return redirect_back(fallback_location: root_path, alert: 'Such coupon not exist') unless result['model']

    return redirect_back(fallback_location: root_path, alert: 'Coupon expired') unless result['coupon.relevant']

    redirect_back(fallback_location: root_path, notice: 'Coupon has been applied')
  end
end
