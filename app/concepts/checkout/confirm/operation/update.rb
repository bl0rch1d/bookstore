class Checkout::Confirm::Update < Trailblazer::Operation
  step Nested(Checkout::Confirm::Edit)
  success :complete_order

  def complete_order(_ctx, params:, **)
    current_order = params[:current_order].decorate

    current_order.update(number: current_order.generate_number,
                         total_price: current_order.total,
                         completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))
  end
end
