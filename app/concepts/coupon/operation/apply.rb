class Coupon::Apply < Trailblazer::Operation
  step Policy::Guard(Coupon::Policy::ApplyGuard.new), fail_fast: true
  step :model, fail_fast: true
  step :unused?, fail_fast: true
  step :use

  def model(ctx, params:, **)
    ctx['model'] = Coupon.find_by(code: params[:code])
  end

  def unused?(ctx, **)
    ctx['coupon.unused'] = !ctx['model'].used
  end

  def use(ctx, params:, **)
    ctx['model'].used = true
    params[:order].coupon = ctx['model']
  end
end
