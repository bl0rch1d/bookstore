class OrderItem::Delete < Trailblazer::Operation
  step Model(OrderItem, :find_by)
  step :delete

  def delete(ctx, **)
    ctx['model'].destroy
  end
end
