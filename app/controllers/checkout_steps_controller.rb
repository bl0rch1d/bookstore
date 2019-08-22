class CheckoutStepsController < ApplicationController
  include Wicked::Wizard
  include AddressFormsExtractor
  include CheckoutInitializer

  before_action :fast_authenticate_user!, :initialize_checkout_user
  steps :address, :shipping, :payment, :confirm, :complete

  def show
    Checkout::Processor.new(controller: self, action: action_name, step: @step).call

    if @operation_result.success?
      resolve_step_data

      render_wizard
    else
      failed_present_step
    end
  end

  def update
    Checkout::Processor.new(controller: self, action: action_name, step: @step).call

    if @operation_result.success?
      render_wizard current_order
    else
      resolve_step_data

      render_wizard
    end
  end

  private

  def resolve_step_data
    case step
    when :address   then extract_address_forms(@operation_result)
    when :payment   then @credit_card_form = @operation_result['contract.default']

    when :complete
      session[:current_order_id] = nil

      @order = @operation_result['model'].decorate

    when :shipping
      @shipping_methods = ShippingMethod.all

      flash.alert = I18n.t('checkout.shipping.errors.blank') if action_name == 'update'
    end
  end

  def failed_present_step
    case step
    when :address then redirect_back(fallback_location: root_path)
    when :complete then redirect_to user_order_path(current_user, current_user.orders.completed.last)
    else redirect_to checkout_step_path(@previous_step)
    end
  end
end
