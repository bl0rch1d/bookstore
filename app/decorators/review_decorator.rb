class ReviewDecorator < Draper::Decorator
  delegate_all

  def customer_initials
    "#{customer_full_name.split(' ').map(&:first).join}"
  end

  def customer_full_name
    "#{customer.billing_address.first_name} #{customer.billing_address.last_name}"
  end
end
