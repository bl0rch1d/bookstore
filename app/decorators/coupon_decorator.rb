class CouponDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def format_discount
    number_to_percentage(discount * 100, precision: 0)
  end

  def calculated_discount
    (discount * order.decorate.subtotal).round(2)
  end
end
