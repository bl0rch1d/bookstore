class OrderItem::Index < Trailblazer::Operation
  step :model
  step :order

  def model(ctx, params:, **)
    ctx['model'] = params[:order].order_items
  end

  def order(ctx, **)
    ctx['model'].order('quantity DESC')
  end
end
