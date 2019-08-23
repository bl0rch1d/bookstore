# rubocop: disable Metrics/ClassLength
class CheckoutStepsController < ApplicationController
  include Wicked::Wizard
  include AddressFormsExtractor
  include CheckoutInitializer

  before_action :fast_authenticate_user!, :initialize_checkout_user
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

  def service_params
    {
      current_order: current_order,
      current_user: current_user,
      step: @step
    }
  end

  def address
    result = Checkout::Address::Present.call(service_params)

    authorize!(result)

    if result.success?
      extract_address_forms(result)
      render_wizard
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update_address
    result = Checkout::Address.call(params.merge(service_params))

    authorize!(result)

    if result.success?
      render_wizard current_order
    else
      extract_address_forms(result)
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
    result = Checkout::Shipping.call(params.merge(service_params))

    authorize!(result)

    if result.success?
      render_wizard current_order
    else
      @shipping_methods = ShippingMethod.all
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
    result = Checkout::Payment.call(params.merge(service_params))

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
    result = Checkout::Complete.call(params.merge(service_params))

    authorize!(result)

    if result.success?
      session[:current_order_id] = nil
      @order = result['model'].decorate
      render_wizard
    else
      redirect_to user_order_path(current_user, current_user.orders.completed.last)
    end
  end
  # rubocop:enable Metrics/AbcSize
end
# rubocop: enable Metrics/ClassLength
