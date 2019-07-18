class Checkout::Payment < Trailblazer::Operation
  step :model
  step Contract::Build(constant: CreditCard::Contract::Create)
  step :validate, fail_fast: true
  step :persist

  def model(ctx, params:, **)
    ctx['model'] = CreditCard.find_or_create_by(order_id: ctx[:order_id])
  end

  def validate(ctx, params:, **)
    ctx['contract.default'].validate(params[:order][:credit_card].to_unsafe_h)
  end

  def persist(ctx, params:, **)
    ctx['model'].update(params[:order][:credit_card].to_unsafe_h)
  end
end
