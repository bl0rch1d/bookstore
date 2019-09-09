class OrderItem::Index < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::IndexGuard.new, name: :user), fail_fast: true
  step :model
  step :order

  def model(ctx, params:, **)
    ctx['model'] = params[:current_order].order_items.includes(:book)
  end

  def order(ctx, **)
    ctx['model'].order('quantity DESC')
  end
end
