class Checkout::Addresses < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new), fail_fast: true
    step :create_forms

    def create_forms(ctx, params:, **)
      ctx['billing_address_form'] = Address::Contract::Create.new(
        params['current_order'].billing_address ||
        params['current_user'].billing_address ||
        BillingAddress.new
      )

      ctx['shipping_address_form'] = Address::Contract::Create.new(
        params['current_order'].shipping_address ||
        params['current_user'].shipping_address ||
        ShippingAddress.new
      )
    end
  end

  step Nested(Present)
  step :validate
  success :set_addresses

  def validate(ctx, params:, **)
    return ctx['billing_address_form'].validate(params['billing_address_params']) if params['use_billing_address']

    billing = ctx['billing_address_form'].validate(params['billing_address_params'])
    shipping = ctx['shipping_address_form'].validate(params['shipping_address_params'])

    billing && shipping
  end

  def set_addresses(_ctx, params:, **)
    params['current_order'].billing_address = BillingAddress.new(params['billing_address_params'].to_unsafe_h)

    params['current_order'].shipping_address = if params['use_billing_address']
                                                 ShippingAddress.new(params['billing_address_params'].to_unsafe_h)
                                               else
                                                 ShippingAddress.new(params['shipping_address_params'].to_unsafe_h)
                                               end
  end
end
