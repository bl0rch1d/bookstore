class Checkout::Complete < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
  step :model
  success :clear_session

  def model(ctx, params:, **)
    ctx['model'] = params['current_order']
  end

  def clear_session(_ctx, params:, **)
    params['session'][:current_order_id] = nil
  end
end
