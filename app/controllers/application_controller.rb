class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  private

  def current_order
    @current_order ||= obtain_order
  end

  def obtain_order
    Order.find_or_create_by(id: order_id)
  end

  def order_id
    session[:current_order_id]
  end
end
