class Checkout::Payment < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
    step :create_form

    def create_form(ctx, params:, **)
      ctx['contract.default'] = Checkout::Contract::CreditCard.new(
        params['current_order'].credit_card || CreditCard.new
      )
    end
  end

  step Nested(Present)
  step :model
  step :validate, fail_fast: true
  step :persist

  def model(ctx, params:, **)
    ctx['model'] = CreditCard.find_or_create_by(order_id: params['current_order'].id)
  end

  def validate(ctx, params:, **)
    ctx['contract.default'].validate(params['credit_card'].to_unsafe_h)
  end

  def persist(ctx, params:, **)
    ctx['model'].update(params['credit_card'].to_unsafe_h)
  end
end
