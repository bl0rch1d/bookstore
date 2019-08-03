class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_resource_name, resource)
    binding.pry

    sign_in(resource)

    current_order.order_items.any? ? checkout_path(:address) : root_path
  end
end