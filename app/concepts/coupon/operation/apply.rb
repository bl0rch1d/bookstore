class Coupon::Apply < Trailblazer::Operation
  step Policy::Guard(Coupon::Policy::ApplyGuard.new), fail_fast: true
  step :model, fail_fast: true
  step :expired?
  step :link_to_order

  def model(ctx, params:, **)
    ctx['model'] = Coupon.find_by(code: params[:code])
  end

  def expired?(ctx, **)
    ctx['coupon.relevant'] = Time.now.to_i <= ctx['model'].expire_date.to_i
  end

  def link_to_order(ctx, params:, **)
    params[:order].coupon = ctx['model']
  end
end
