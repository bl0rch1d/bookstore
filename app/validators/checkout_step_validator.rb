class CheckoutStepValidator
  def initialize(current_order, step)
    @current_order = current_order
    @step = step
  end

  def step_allowed?
    case @step
    when :address   then true
    when :shipping  then shipping?
    when :payment   then payment?
    when :confirm   then confirm?
    when :complete  then complete?
    end
  end

  def shipping?
    @current_order.billing_address && @current_order.shipping_address
  end

  def payment?
    @current_order.shipping_method_id.present?
  end

  def confirm?
    @current_order.credit_card.present?
  end

  def complete?
    @current_order.number.present?
  end
end
