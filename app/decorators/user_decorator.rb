class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :billing_address
  decorates_association :shipping_address
end
