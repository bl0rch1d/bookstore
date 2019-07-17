class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :fast_authenticate_customer!
  steps :address, :shipping, :payment, :confirm, :complete

  # === TODO: Keep calm. Will be refactored. ===
  # === TODO: Forms client validation ===
  def show
    case step
    when :address   then address
    when :shipping  then shipping
    when :payment   then payment
    when :complete  then @order = current_customer.orders.last
    end

    render_wizard
  end

  def update
    case step
    when :address   then update_address
    when :shipping  then update_shipping
    when :payment   then update_payment
    when :confirm   then finalize_order
    end

    render_wizard current_order
  end

  private

  def address
    # @billing_address_form = BillingAddressForm.new(BillingAddress.new)
    # @shipping_address_form = ShippingAddressForm.new(ShippingAddress.new)

    current_order.billing_address = Address::Create::Present.call['model']
    current_order.shipping_address = Address::Create::Present.call['model']
  end

  def update_address
    binding.pry

    # current_order.billing_address = BillingAddress.new
    # current_order.shipping_address = ShippingAddress.new

    # @billing_address_form = BillingAddressForm.new(current_order.billing_address)
    # @shipping_address_form = ShippingAddressForm.new(current_order.shipping_address)

    # if address_params_valid?
    #   current_order.billing_address.update(billing_address_params)

    #   use_billing? ? current_order.shipping_address.update(billing_address_params) : current_order.shipping_address.update(shipping_address_params)

    #   return
    # else
    #   render_wizard
    # end
  end

  # def address_params_valid?
  #   return @billing_address_form.validate(billing_address_params) if use_billing?

  #   @billing_address_form.validate(billing_address_params) && @shipping_address_form.validate(shipping_address_params)
  # end

  def shipping
    @shipping_methods = ShippingMethod.all
  end

  def update_shipping
    current_order.update(shipping_method_id: params[:order][:shipping_method_id])
  end

  def payment
    current_order.credit_card = CreditCard.new
  end

  def update_payment
    current_order.credit_card.update(params[:order][:credit_card].to_unsafe_h)
  end

  def finalize_order
    current_order.update(number: current_order.decorate.generate_number,
                         customer_id: current_customer.id,
                         total_price: current_order.decorate.total,
                         completed_at: Time.zone.now.strftime('%d %b %Y - %H:%M:%S'))

    session[:current_order_id] = nil
  end

  def fast_authenticate_customer!
    redirect_to customers_fast_new_path unless current_customer
  end

  # def billing_address_params
  #   params.require(:order).permit(billing_address: Address::FIELDS)[:billing_address]
  # end

  # def shipping_address_params
  #   params.require(:order).permit(shipping_address: Address::FIELDS)[:shipping_address]
  # end

  # def use_billing?
  #   params.require(:order).permit(:use_billing)[:use_billing] == 'true'
  # end
end
