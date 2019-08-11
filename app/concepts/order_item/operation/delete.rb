class OrderItem::Delete < Trailblazer::Operation
  step Policy::Guard(OrderItem::Policy::UpdateGuard.new, name: :user)
  step Model(OrderItem, :find_by)
  step :destroy

  def destroy(ctx, **)
    ctx['model'].destroy
  end
end
