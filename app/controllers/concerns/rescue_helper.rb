module RescueHelper
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken, with: -> { sign_out current_user }

    rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

    rescue_from Wicked::Wizard::InvalidStepError, with: :page_not_found

    rescue_from TrailblazerExecutor::NotAuthorized, with: :not_authorized

    def page_not_found
      render file: Rails.root.join('public', '404.html'), layout: false, status: :not_found
    end

    def not_authorized
      redirect_to(root_path, alert: I18n.t('auth.errors.not_authorized'))
    end
  end
end
