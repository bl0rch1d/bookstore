class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :cart_emptiness_check!, :fast_authenticate_customer!
  steps :address, :shipping, :payment, :confirm, :complete

  def show
    case step
    when :address   then address
    when :shipping  then shipping
    when :payment   then payment
    when :confirm   then confirm
    when :complete  then complete
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

  def cart_emptiness_check!
    redirect_back(fallback_location: root_path, alert: I18n.t('order_item.errors.no_items')) unless current_order.order_items.any?
  end

  def fast_authenticate_customer!
    redirect_to customers_fast_new_path unless current_customer
  end

  def checkout_params
    {
      'current_order' => current_order,
      'current_customer' => current_customer,
      'shipping_method_id' => params.dig(:order, :shipping_method_id),
      'billing_address_params' => params.dig(:order, :billing_address)&.to_unsafe_h,
      'shipping_address_params' => params.dig(:order, :shipping_address)&.to_unsafe_h,
      'use_billing_address' => params.dig(:order, :use_billing) == 'true',
      'session' => session,
      'credit_card' => params.dig(:order, :credit_card),
      'step' => @step
    }
  end

  def address
    Checkout::Initialize.call(checkout_params)
    result = Checkout::Addresses::Present.call(checkout_params)

    if result.success?
      expose_address_forms(result)
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update_address
    result = Checkout::Addresses.call(checkout_params)

    if result.success?
      render_wizard current_order
    else
      expose_address_forms(result)
      render_wizard
    end
  end

  def expose_address_forms(result)
    @billing_address_form   = result['billing_address_form']
    @shipping_address_form  = result['shipping_address_form']
  end

  def shipping
    result = Checkout::Shipping::Present.call(checkout_params)

    if result.success?
      @shipping_methods = result['model']
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update_shipping
    result = Checkout::Shipping.call(checkout_params)

    if result.success?
      render_wizard current_order
    else
      render_wizard
    end
  end

  def payment
    result = Checkout::Payment::Present.call(checkout_params)

    if result.success?
      @credit_card_form = result['contract.default']
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update_payment
    result = Checkout::Payment.call(checkout_params)

    if result.success?
      render_wizard current_order
    else
      @credit_card_form = result['contract.default']
      render_wizard
    end
  end

  def confirm
    result = Checkout::Confirm::Present.call(checkout_params)

    if result.success?
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def finalize_order
    result = Checkout::Confirm.call(checkout_params)

    if result.success?
      @credit_card_form = result['contract.default']
      redirect_to next_wizard_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def complete
    result = Checkout::Complete.call(checkout_params)

    if result.success?
      @order = result['model']
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
