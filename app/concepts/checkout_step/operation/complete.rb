class CheckoutStep::Complete < Trailblazer::Operation
  step Policy::Guard(CheckoutStep::Policy::UserGuard.new, name: :user), fail_fast: true
  step Policy::Guard(CheckoutStep::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true
  step Policy::Guard(CheckoutStep::Policy::StepGuard.new, name: :step), fail_fast: true

  step :model
  success :clear_session
  success :mail

  def model(ctx, params:, **)
    ctx['model'] = params[:current_order]
  end

  def clear_session(_ctx, params:, **)
    params[:session][:current_order_id] = nil
  end

  def mail(_ctx, params:, **)
    CheckoutMailer.complete(params[:current_user].id, params[:current_order].id).deliver_later
  end
end