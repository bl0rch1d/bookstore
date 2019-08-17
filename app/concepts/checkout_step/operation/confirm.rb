class CheckoutStep::Confirm < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(CheckoutStep::Policy::UserGuard.new, name: :user), fail_fast: true
    step Policy::Guard(CheckoutStep::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true
    step Policy::Guard(CheckoutStep::Policy::StepGuard.new, name: :step), fail_fast: true
  end

  step Nested(Present)
  success :complete_order

  def complete_order(_ctx, params:, **)
    current_order = params[:current_order].decorate

    current_order.update(number: current_order.generate_number,
                         total_price: current_order.total,
                         completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))
  end
end
