class Order::Index < Trailblazer::Operation
  step Policy::Guard(Order::Policy::IndexGuard.new, name: :user), fail_fast: true
  step :model

  def model(ctx, params:, **)
    ctx['model'] = Order::Query::Index.new.call(params[:current_user], params)
  end
end
