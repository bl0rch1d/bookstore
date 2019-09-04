class Checkout::Addresses::Update < Trailblazer::Operation
  step Nested(Checkout::Addresses::Edit)
  success :extract_params
  step :validate, fail_fast: true
  step :persist

  def extract_params(ctx, params:, **)
    ctx['billing_params'] = params[:order][:billing_address]
    ctx['shipping_params'] = params[:order][:use_billing] ? ctx['billing_params'] : params[:order][:shipping_address]
  end

  def validate(ctx, **)
    billing = ctx['billing_address_form'].validate(ctx['billing_params'])
    shipping = ctx['shipping_address_form'].validate(ctx['shipping_params'])

    billing && shipping
  end

  def persist(ctx, **)
    ActiveRecord::Base.transaction do
      ctx['billing_address_form'].save
      ctx['shipping_address_form'].save
    end
  end
end
