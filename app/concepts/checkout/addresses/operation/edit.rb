class Checkout::Addresses::Edit < Trailblazer::Operation
  step Policy::Guard(Checkout::Policy::UserGuard.new, name: :user), fail_fast: true

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
