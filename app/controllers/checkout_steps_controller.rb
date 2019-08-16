# rubocop: disable Metrics/ClassLength
class CheckoutStepsController < ApplicationController
  include Wicked::Wizard
  include AddressFormHelper

  before_action :fast_authenticate_user!, :initialize_user
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

  def initialize_user
    Checkout::Initialize.call(service_params) unless current_order.user
  end

  def fast_authenticate_user!
    redirect_to users_fast_new_path unless current_user
  end

  def service_params
    {
      current_order: current_order,
      current_user: current_user,
      step: @step
    }
  end

  def address_params
    {
      billing_address_params: params.dig(:order, :billing_address),
      shipping_address_params: params.dig(:order, :shipping_address),
      use_billing_address: params.dig(:order, :use_billing) == 'true'
    }
  end

  def address
    result = Checkout::Addresses::Present.call(service_params)

    authorize!(result)

    if result.success?
      expose_address_forms(result)
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update_address
    result = Checkout::Addresses.call(service_params.merge(address_params))

    authorize!(result)

    if result.success?
      render_wizard current_order
    else
      expose_address_forms(result)
      render_wizard
    end
  end

  def shipping
    result = Checkout::Shipping::Present.call(service_params)

    authorize!(result)

    if result.success?
      @shipping_methods = result['model']
      render_wizard
    else
      redirect_to checkout_step_path(@previous_step)
    end
  end

  def update_shipping
    result = Checkout::Shipping.call(service_params.merge(
                                       shipping_method_id: params.dig(:order, :shipping_method_id)
                                     ))

    authorize!(result)

    if result.success?
      render_wizard current_order
    else
      flash.alert = I18n.t('checkout.shipping.errors.blank')
      render_wizard
    end
  end

  def payment
    result = Checkout::Payment::Present.call(service_params)

    authorize!(result)

    if result.success?
      @credit_card_form = result['contract.default']
      render_wizard
    else
      redirect_to checkout_step_path(@previous_step)
    end
  end

  def update_payment
    result = Checkout::Payment.call(service_params.merge(credit_card: params.dig(:order, :credit_card)))

    authorize!(result)

    if result.success?
      render_wizard current_order
    else
      @credit_card_form = result['contract.default']
      render_wizard
    end
  end

  def confirm
    result = Checkout::Confirm::Present.call(service_params)

    authorize!(result)

    render_wizard
  end

  def finalize_order
    result = Checkout::Confirm.call(service_params)

    authorize!(result)

    render_wizard current_order
  end

  # rubocop:disable Metrics/AbcSize
  def complete
    result = Checkout::Complete.call(service_params.merge(session: session))

    authorize!(result)

    if result.success?
      @order = result['model'].decorate
      render_wizard
    else
      redirect_to user_order_path(current_user, current_user.orders.completed.last)
    end
  end
  # rubocop:enable Metrics/AbcSize
end
# rubocop: enable Metrics/ClassLength
