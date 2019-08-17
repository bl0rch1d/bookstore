class CheckoutStep::Policy::StepGuard
  include Uber::Callable

  def call(_ctx, params:, **)
    @current_order = params[:current_order]

    case params[:step]
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
