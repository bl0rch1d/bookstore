class CouponDecorator < Draper::Decorator
  delegate_all

  def format_discount
    (discount * 100).to_s.split('.')[0] + '%'
  end

  def calculated_discount
    (discount * order.decorate.subtotal).round(2)
  end
end
