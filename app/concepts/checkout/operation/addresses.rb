class Checkout::Addresses < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :create_forms

    def create_forms(ctx, params:, **)
      ctx['billing_address_form'] = Checkout::Contract::Address.new(
        params['current_order'].billing_address ||
        params['current_customer'].billing_address ||
        BillingAddress.new
      )

      ctx['shipping_address_form'] = Checkout::Contract::Address.new(
        params['current_order'].shipping_address ||
        params['current_customer'].shipping_address ||
        ShippingAddress.new
      )
    end
  end

  step Nested(Present)
  step :validate
  step :set_addresses

  def validate(ctx, params:, **)
    billing_address_params = params.dig(:order, :billing_address).to_unsafe_h
    shipping_address_params = params.dig(:order, :shipping_address).to_unsafe_h
    use_billing = params.dig(:order, :use_billing) == 'true'

    return ctx['billing_address_form'].validate(billing_address_params) if use_billing

    ctx['billing_address_form'].validate(billing_address_params) &&
      ctx['shipping_address_form'].validate(shipping_address_params)
  end

  # === TODO: Fix addresses ===
  def set_addresses(_ctx, params:, **)
    billing_address_params = params.dig(:order, :billing_address)
    shipping_address_params = params.dig(:order, :shipping_address)
    use_billing = params.dig(:order, :use_billing) == 'true'

    params['current_order'].billing_address = BillingAddress.new(billing_address_params.to_unsafe_h)

    params['current_order'].shipping_address = if use_billing
                                                 ShippingAddress.new(billing_address_params.to_unsafe_h)
                                               else
                                                 ShippingAddress.new(shipping_address_params.to_unsafe_h)
                                               end
  end
end
