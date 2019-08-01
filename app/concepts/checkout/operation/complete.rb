class Checkout::Complete < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
  step :model
  success :clear_session
  success :send_confirmation_email

  def model(ctx, params:, **)
    ctx['model'] = params['current_order']
  end

  def clear_session(_ctx, params:, **)
    params['session'][:current_order_id] = nil
  end

  def send_confirmation_email(_ctx, params:, **)
    CheckoutMailer.with(user: params['current_user'], order: params['current_order']).order_check.deliver_later
  end
end
