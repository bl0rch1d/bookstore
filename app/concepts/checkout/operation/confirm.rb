class Checkout::Confirm < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
  end

  step Nested(Present)
  success :complete_order

  def complete_order(_ctx, params:, **)
    current_order = params['current_order']

    current_order.update(number: current_order.decorate.generate_number,
                         total_price: current_order.decorate.total,
                         completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))
  end
end
