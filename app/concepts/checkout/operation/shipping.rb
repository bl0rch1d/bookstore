class Checkout::Shipping < Trailblazer::Operation
  step Model(ShippingMethod, :find_by)
  success :link_to_order

  def link_to_order(ctx, params:, **)
    params['current_order'].update(shipping_method_id: ctx['model'].id)
  end
end
