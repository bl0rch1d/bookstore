class OrderItem::Delete < Trailblazer::Operation
  step Model(OrderItem, :find_by)
  step :destroy

  def destroy(ctx, **)
    ctx['model'].destroy
  end
end
