module RescueHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken, with: -> { sign_out current_user }

    rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

    rescue_from ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordInvalid, with: :unprocessable_entity

    rescue_from Wicked::Wizard::InvalidStepError, with: :page_not_found

    rescue_from Exceptions::NotAuthorized, with: :not_authorized

    def page_not_found
      render file: Rails.root.join('public', '404.html'), layout: false, status: :not_found
    end

    def not_authorized
      redirect_to(root_path, alert: I18n.t('auth.errors.not_authorized'))
    end

    def unprocessable_entity
      redirect_back(fallback_location: root_path, alert: I18n.t('validation_errors.unprocessable_entity'))
    end
  end
end
