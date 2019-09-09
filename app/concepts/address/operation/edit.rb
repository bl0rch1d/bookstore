class Address::Edit < Trailblazer::Operation
  step Policy::Guard(Address::Policy::EditGuard.new, name: :user), fail_fast: true
  success :create_forms

  def create_forms(ctx, params:, **)
    ctx['billing_address_form'] = Address::Contract::Create.new(
      params[:current_user].billing_address || BillingAddress.new
    )

    ctx['shipping_address_form'] = Address::Contract::Create.new(
      params[:current_user].shipping_address || ShippingAddress.new
    )
  end
end
