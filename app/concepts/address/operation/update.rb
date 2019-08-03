class Address::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :create_forms

    def create_forms(ctx, params:, **)
      ctx['billing_address_form'] = Address::Contract::Create.new(
        params['current_user'].billing_address ||
        BillingAddress.new
      )

      ctx['shipping_address_form'] = Address::Contract::Create.new(
        params['current_user'].shipping_address ||
        ShippingAddress.new
      )
    end
  end

  step Nested(Present)
  success :extract_params
  step :validate
  step :persist

  def extract_params(ctx, params:, **)
    ctx['billing_params'] = params.dig(:user, :billing_address_attributes)
    ctx['shipping_params'] = params.dig(:user, :shipping_address_attributes)
  end

  def validate(ctx, params:, **)
    billing = ctx['billing_address_form'].validate(ctx['billing_params']) if ctx['billing_params']
    shipping = ctx['shipping_address_form'].validate(ctx['shipping_params']) if ctx['shipping_params']

    billing || shipping
  end

  def persist(ctx, params:, **)
    ctx['billing_address_form'].save || ctx['shipping_address_form'].save
  end
end