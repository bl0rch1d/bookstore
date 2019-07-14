class ShippingMethodDecorator < Draper::Decorator
  delegate_all

  # def shipping_interval
  #   "#{min_days} to #{max_days} days"
  # end
end
