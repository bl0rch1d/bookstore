class Checkout::Policy::CheckoutGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    customer_allowed?(params) && order_items_valid?(params) && step_allowed?(params['step'], params['current_order'])
  end

  def step_allowed?(step, current_order)
    case step
    when :address   then !current_order.customer_id.nil?
    when :shipping  then current_order.billing_address && current_order.shipping_address
    when :payment   then !current_order.shipping_method_id.nil?
    when :confirm   then !current_order.credit_card.nil?
    when :complete  then !current_order.number.nil?
    end
  end

  def customer_allowed?(params)
    params['current_order'].customer_id == params['current_customer'].id
  end

  def order_items_valid?(params)
    params['current_order'].order_items.any?
  end
end
