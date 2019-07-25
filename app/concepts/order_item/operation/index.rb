class OrderItem::Index < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::IndexGuard.new), fail_fast: true
  step :model
  step :order

  def model(ctx, params:, **)
    ctx['model'] = params[:order].order_items
  end

  def order(ctx, **)
    ctx['model'].order('quantity DESC')
  end
end
