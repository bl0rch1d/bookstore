class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::InvalidAuthenticityToken, with: -> { sign_out current_user }

  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  rescue_from Wicked::Wizard::InvalidStepError, with: :page_not_found

  rescue_from Exceptions::NotAuthorized, with: :not_authorized

  helper_method :current_order

  private

  def page_not_found
    render file: Rails.root.join('public', '404.html'), layout: false, status: :not_found
  end

  def not_authorized
    redirect_to(root_path, alert: I18n.t('auth.errors.not_authorized'))
  end

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
