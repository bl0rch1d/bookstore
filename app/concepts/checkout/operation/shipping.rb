class Checkout::Shipping < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
    step :model

    def model(ctx, **)
      ctx['model'] = ShippingMethod.all
    end
  end

  step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
  step :model
  success :link_to_order

  def model(ctx, params:, **)
    ctx['model'] = ShippingMethod.find_by(id: params['shipping_method_id'])
  end

  def link_to_order(ctx, params:, **)
    params['current_order'].update(shipping_method_id: ctx['model'].id)
  end
end
