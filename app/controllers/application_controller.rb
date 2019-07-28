class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_order

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  def current_order
    @current_order ||= obtain_order
  end

  def obtain_order
    order = Order.find_or_create_by(id: order_id)
    session[:current_order_id] = order.id

    order
  end

  def order_id
    session[:current_order_id]
  end

  def expose_address_forms(result)
    @billing_address_form   = result['billing_address_form']
    @shipping_address_form  = result['shipping_address_form']
  end
end
