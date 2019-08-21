class Checkout::Payment < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true
    step Policy::Guard(Checkout::Policy::StepGuard.new, name: :step), fail_fast: true

    step :model
    step Contract::Build(constant: Checkout::Contract::CreditCard)

    def model(ctx, params:, **)
      ctx['model'] = params[:current_order].credit_card || CreditCard.new
    end
  end

  step Nested(Present)
  success :extract_params
  step Contract::Validate(key: :credit_card), fail_fast: true
  step Contract::Persist()

  def extract_params(_ctx, params:, **)
    params[:credit_card] = params.dig(:order, :credit_card)
  end
end
