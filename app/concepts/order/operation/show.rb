class Order::Show < Trailblazer::Operation
  step Policy::Guard(Order::Policy::ShowGuard.new, name: :user), fail_fast: true
  step :model

  def model(ctx, params:, **)
    ctx['model'] = params[:current_user].orders.where(id: params[:id])[0]
  end
end
