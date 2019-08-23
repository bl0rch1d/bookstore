class Checkout::Complete < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true
  step Policy::Guard(Checkout::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true
  step Policy::Guard(Checkout::Policy::StepGuard.new, name: :step), fail_fast: true

  step :model, fail_fast: true
  success :mail

  def model(ctx, params:, **)
    ctx['model'] = params[:current_order]
  end

  def mail(_ctx, params:, **)
    CheckoutMailer.complete(params[:current_user].id, params[:current_order].id).deliver_later
  end
end
