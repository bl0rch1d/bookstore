class Checkout::Policy::CheckoutGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    @current_order  = params['current_order']
    @current_user   = params['current_user']
    @step           = params['step']

    user_allowed? && order_items_valid? && step_allowed?
  end

  def step_allowed?
    case @step
    when :address   then address?
    when :shipping  then shipping?
    when :payment   then payment?
    when :confirm   then confirm?
    when :complete  then complete?
    end
  end

  def user_allowed?
    @current_order.user_id == @current_user.id
  end

  def order_items_valid?
    @current_order.order_items.any?
  end

  def address?
    !@current_order.user_id.nil?
  end

  def shipping?
    @current_order.billing_address && @current_order.shipping_address
  end

  def payment?
    !@current_order.shipping_method_id.nil?
  end

  def confirm?
    !@current_order.credit_card.nil?
  end

  def complete?
    !@current_order.number.nil?
  end
end
