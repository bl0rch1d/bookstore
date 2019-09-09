class Address::Policy::UpdateGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    user = params[:current_user]
    addressable = params.dig(:user, :billing_address_attributes, :addressable_id) ||
                  params.dig(:user, :shipping_address_attributes, :addressable_id)

    addressable.to_i == user&.id
  end
end
