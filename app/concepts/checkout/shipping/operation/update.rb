class Checkout::Shipping::Update < Trailblazer::Operation
  step Nested(Checkout::Shipping::Edit)
  step :model
  success :link_to_order

  def model(ctx, params:, **)
    ctx['model'] = ShippingMethod.find_by(id: params.dig(:order, :shipping_method_id))
  end

  def link_to_order(ctx, params:, **)
    params[:current_order].update(shipping_method_id: ctx['model'].id)
  end
end
