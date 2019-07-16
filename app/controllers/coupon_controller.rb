class CouponController < ApplicationController
  def apply
    coupon = Coupon.find_by(code: params[:code])

    return redirect_back(fallback_location: root_path, alert: 'Such coupon not exist') unless coupon

    return redirect_back(fallback_location: root_path, alert: 'Coupon expired') if coupon.expired?

    current_order.coupon = coupon

    redirect_back(fallback_location: root_path, notice: 'Coupon has been applied')
  end
end
