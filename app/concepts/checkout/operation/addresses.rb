class Checkout::Addresses < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true
    step Policy::Guard(Checkout::Policy::CheckoutGuard.new, name: :checkout), fail_fast: true

    success :create_forms

    def create_forms(ctx, params:, **)
      order = params[:current_order]
      user = params[:current_user]

      ctx['billing_address_form'] = Address::Contract::Create.new(
        order.billing_address ||
        BillingAddress.new(user.billing_address&.attributes&.except('id'))
      )

      ctx['shipping_address_form'] = Address::Contract::Create.new(
        order.shipping_address ||
        ShippingAddress.new(user.shipping_address&.attributes&.except('id'))
      )
    end
  end

  step Nested(Present)
  success :extract_params
  step :validate
  step :set_addresses

  def extract_params(ctx, params:, **)
    ctx['billing_params'] = params[:billing_address_params]
    ctx['shipping_params'] = params[:use_billing_address] ? ctx['billing_params'] : params[:shipping_address_params]
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
