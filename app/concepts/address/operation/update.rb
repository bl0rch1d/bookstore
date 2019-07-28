class Address::Update < Trailblazer::Operation
  # === TODO: specs ===

  class Present < Trailblazer::Operation
    step :create_forms

    def create_forms(ctx, params:, **)
      ctx['billing_address_form'] = Checkout::Contract::Address.new(
        params['current_user'].billing_address ||
        BillingAddress.new
      )

      ctx['shipping_address_form'] = Checkout::Contract::Address.new(
        params['current_user'].shipping_address ||
        ShippingAddress.new
      )
    end
  end

  step Nested(Present)
  step :validate
  success :set_addresses

  def validate(ctx, params:, **)
    ctx['billing_params'] = params.dig(:user, :billing_address_attributes)
    ctx['shipping_params'] = params.dig(:user, :shipping_address_attributes)

    billing = ctx['billing_address_form'].validate(ctx['billing_params']) if ctx['billing_params']
    shipping = ctx['shipping_address_form'].validate(ctx['shipping_params']) if ctx['shipping_params']

    billing || shipping
  end

  def set_addresses(ctx, params:, **)
    ctx['billing_address_form'].save if ctx['billing_params']

    ctx['shipping_address_form'].save if ctx['shipping_params']
  end
end
