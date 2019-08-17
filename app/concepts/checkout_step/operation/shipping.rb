class CheckoutStep::Shipping < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(CheckoutStep::Policy::UserGuard.new, name: :user), fail_fast: true
    step Policy::Guard(CheckoutStep::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true
    step Policy::Guard(CheckoutStep::Policy::StepGuard.new, name: :step), fail_fast: true

    step :model

    def model(ctx, **)
      ctx['model'] = ShippingMethod.all
    end
  end

  step Nested(Present)
  step :model
  success :link_to_order

  def model(ctx, params:, **)
    ctx['model'] = ShippingMethod.find_by(id: params[:shipping_method_id])
  end

  def link_to_order(ctx, params:, **)
    params[:current_order].update(shipping_method_id: ctx['model'].id)
  end
end
