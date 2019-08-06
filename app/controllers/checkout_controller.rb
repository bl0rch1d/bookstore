# rubocop: disable Metrics/ClassLength
class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :fast_authenticate_user!, :link_user_to_order
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

  def link_user_to_order
    Checkout::Initialize.call(checkout_params) unless current_order.user
  end

  def fast_authenticate_user!
    redirect_to users_fast_new_path unless current_user
  end

  def checkout_params
    {
      'current_order' => current_order,
      'current_user' => current_user,
      'step' => @step,
      'shipping_method_id' => params.dig(:order, :shipping_method_id),
      'billing_address_params' => params.dig(:order, :billing_address),
      'shipping_address_params' => params.dig(:order, :shipping_address),
      'use_billing_address' => params.dig(:order, :use_billing) == 'true',
      'credit_card' => params.dig(:order, :credit_card)
    }
  end

  def address
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
      flash.alert = I18n.t('checkout.shipping.errors.blank')
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
      render_wizard current_order
    else
      render_wizard
    end
  end

  def complete
    result = Checkout::Complete.call(checkout_params.merge('session' => session))

    if result.success?
      @order = result['model'].decorate

      render_wizard
    else
      @order = current_user.orders.completed.last.decorate

      render 'complete'
    end
  end
end
# rubocop: enable Metrics/ClassLength
