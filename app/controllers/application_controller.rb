class ApplicationController < ActionController::Base
  include RescueHandler

  protect_from_forgery with: :exception

  helper_method :current_order

  private

  def current_order
    @current_order ||= Order::Current.call(session: session)['model'].decorate
  end

  def contract_errors(result)
    result['contract.default'] ? result['contract.default'].errors.full_messages : I18n.t('form.invalid_params')
  end

  def authorize!(result)
    return unless result['result.policy.user']

    raise Exceptions::NotAuthorized if result['result.policy.user'].failure?
  end
end
