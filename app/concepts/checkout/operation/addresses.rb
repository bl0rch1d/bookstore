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
  success :extract_params
  step :validate
  step :set_addresses

  def extract_params(ctx, params:, **)
    ctx['billing_params'] = params['billing_address_params']
    ctx['shipping_params'] = params['use_billing_address'] ? ctx['billing_params'] : params['shipping_address_params']
  end

  def validate(ctx, **)
    billing = ctx['billing_address_form'].validate(ctx['billing_params'])
    shipping = ctx['shipping_address_form'].validate(ctx['shipping_params'])

    billing && shipping
  end

  def set_addresses(ctx, **)
    ctx['billing_address_form'].save && ctx['shipping_address_form'].save
  end
end
