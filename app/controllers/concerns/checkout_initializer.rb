module CheckoutInitializer
  extend ActiveSupport::Concern

  included do
    def fast_authenticate_user!
      redirect_to users_fast_new_path unless current_user
    end

    def initialize_checkout_user
      Checkout::Initialize.call(current_order: current_order, current_user: current_user) unless current_order.user
    end
  end
end
