class ApplicationController < ActionController::Base
  include RescueHandler

  protect_from_forgery with: :exception

  helper_method :current_order

  private

  def current_order
    @current_order ||= obtain_order_and_set_session
  end

  # I'm tried to move this logic to operation, but couldn't understand how
  # safely send session to it (not entire session object, but just a pointer for current order id)
  def obtain_order_and_set_session
    order = Order.find_or_create_by(id: session[:current_order_id])
    session[:current_order_id] = order.id

    order.decorate
  end

  def contract_errors(result)
    result['contract.default'] ? result['contract.default'].errors.full_messages : I18n.t('form.invalid_params')
  end
end
