class Order::Addresses < Trailblazer::Operation
  step :model
  step :set_addresses

  def model(ctx, params:, **)
    ctx['model'] = Order.find(ctx[:order_id])
  end

  def set_addresses(ctx, params:, **)
    billing_address_params = params.dig(:order, :billing_address)
    shipping_address_params = params.dig(:order, :shipping_address)

    ctx['model'].billing_address = BillingAddress.new(billing_address_params.to_unsafe_h)

    ctx['model'].shipping_address = if params[:order][:use_billing] == 'true'
                                      ShippingAddress.new(billing_address_params.to_unsafe_h)
                                    else
                                      ShippingAddress.new(shipping_address_params.to_unsafe_h)
                                    end
  end
end
