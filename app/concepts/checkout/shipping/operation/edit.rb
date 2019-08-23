class Checkout::Shipping::Edit < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true

  step :model

  def model(ctx, **)
    ctx['model'] = ShippingMethod.all
  end
end
