class Coupon::Apply < Trailblazer::Operation
  step :model, fast_fail: true
  step :expired?
  step :link_to_order

  def model(ctx, params:, **)
    ctx['model'] = Coupon.find_by(code: params[:code])
  end

  def expired?(ctx, params:, **)
    ctx['coupon.relevant'] = Time.now.to_i <= ctx['model'].expire_date.to_i
  end

  def link_to_order(ctx, params:, **)
    params[:order].coupon = ctx['model']
  end
end
