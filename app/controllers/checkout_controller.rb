class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :fast_authenticate_customer!
  steps :address, :shipping, :payment, :confirm, :complete

  # === TODO: Fix addresses ===
  # === TODO: Errors output ===
  # === TODO: Cart emptiness check ===
  # === TODO: More refactoring ===
  def show
    case step
    when :address   then address
    when :shipping  then shipping
    when :payment   then payment
    when :confirm   then render_wizard
    when :complete
      @order = current_customer.orders.last
      render_wizard
    end
  end

  def update
    case step
    when :address   then update_address
    when :shipping  then update_shipping
    when :payment   then update_payment
    when :confirm   then finalize_order
    end
  end

  private

  def address
    result = Checkout::Addresses::Present.call('current_order' => current_order, 'current_customer' => current_customer)

    @billing_address_form   = result['billing_address_form']
    @shipping_address_form  = result['shipping_address_form']

    render_wizard
  end

  def update_address
    params['current_order'] = current_order
    params['current_customer'] = current_customer

    result = Checkout::Addresses.call(params)

    if result.success?
      render_wizard current_order
    else
      # flash.now.alert = result
      render_wizard
    end
  end

  def shipping
    @shipping_methods = ShippingMethod.all

    render_wizard
  end

  def update_shipping
    result = Checkout::Shipping.call(id: params.dig(:order, :shipping_method_id), 'current_order' => current_order)

    if result.success?
      render_wizard current_order
    else
      flash.now.alert = 'Shipping method must be present'
      render_wizard
    end
  end

  def payment
    @credit_card_form = Checkout::Contract::CreditCard.new(current_order.credit_card || CreditCard.new)

    render_wizard
  end

  def update_payment
    result = Checkout::Payment.call(params, order_id: current_order.id)

    if result.success?
      render_wizard current_order
    else
      flash.now.alert = result['contract.default'].errors.full_messages
      render_wizard
    end
  end

  def finalize_order
    Checkout::Finish.call('current_order' => current_order, 'current_customer' => current_customer, 'session' => session)

    redirect_to next_wizard_path
  end

  def fast_authenticate_customer!
    redirect_to customers_fast_new_path unless current_customer
  end
end

# class CheckoutController < ApplicationController
#   include Wicked::Wizard

#   before_action :fast_authenticate_customer!
#   steps :address, :shipping, :payment, :confirm, :complete

#   def show
#     case step
#     when :address   then address
#     when :shipping  then shipping
#     when :payment   then payment
#     when :confirm   then render_wizard
#     when :complete
#       @order = current_customer.orders.last
#       render_wizard
#     end
#   end

#   def update
#     case step
#     when :address   then update_address
#     when :shipping  then update_shipping
#     when :payment   then update_payment
#     when :confirm   then finalize_order
#     end
#   end

#   private

#   def address
#     create_address_forms

#     render_wizard
#   end

#   def update_address
#     create_address_forms

#     if addresses_params_valid?
#       Order::Addresses.call(params, order_id: current_order.id)
#       render_wizard current_order
#     else
#       render_wizard
#     end
#   end

#   def create_address_forms
#     @billing_address_form = Checkout::Contract::Address.new(
#       current_order.billing_address ||
#       current_customer.billing_address ||
#       BillingAddress.new
#     )

#     @shipping_address_form = Checkout::Contract::Address.new(
#       current_order.shipping_address ||
#       current_customer.shipping_address ||
#       ShippingAddress.new
#     )
#   end

#   def addresses_params_valid?
#     return @billing_address_form.validate(billing_address_params) if use_billing?

#     @billing_address_form.validate(billing_address_params) && @shipping_address_form.validate(shipping_address_params)
#   end

#   def shipping
#     @shipping_methods = ShippingMethod.all

#     render_wizard
#   end

#   def update_shipping
#     shipping_params = params.dig(:order, :shipping_method_id)

#     if shipping_params && current_order.update(shipping_method_id: shipping_params)
#       render_wizard current_order
#     else
#       flash.now.alert = 'Shipping method must be present'
#       render_wizard
#     end
#   end

#   def payment
#     @credit_card_form = CreditCard::Contract::Create.new(current_order.credit_card || CreditCard.new)

#     render_wizard
#   end

#   def update_payment
#     result = CreditCard::Create.call(params, order_id: current_order.id)

#     if result.success?
#       render_wizard current_order
#     else
#       flash.now.alert = result['contract.default'].errors.full_messages
#       render_wizard
#     end
#   end

#   def finalize_order
#     current_order.update(number: current_order.decorate.generate_number,
#                          customer_id: current_customer.id,
#                          total_price: current_order.decorate.total,
#                          completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))

#     session[:current_order_id] = nil

#     redirect_to next_wizard_path
#   end

#   def fast_authenticate_customer!
#     redirect_to customers_fast_new_path unless current_customer
#   end

#   def billing_address_params
#     params.require(:order).permit(billing_address: Address::FIELDS)[:billing_address]
#   end

#   def shipping_address_params
#     params.require(:order).permit(shipping_address: Address::FIELDS)[:shipping_address]
#   end

#   def use_billing?
#     params.require(:order).permit(:use_billing)[:use_billing] == 'true'
#   end
# end
