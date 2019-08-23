module CheckoutGuard
  extend ActiveSupport::Concern

  included do
    def fast_authenticate_user!
      redirect_to users_fast_new_path unless current_user
    end

    def initialize_checkout_user
      Checkout::Initialize.call(current_order: current_order, current_user: current_user) unless current_order.user
    end

    def check_order_items
      redirect_to(root_path, alert: I18n.t('order_item.errors.no_items')) unless current_order.order_items.any?
    end

    def check_step
      redirect_to checkout_step_path(@previous_step) unless CheckoutStepValidator.new(current_order, step).step_allowed?
    end
  end
end
