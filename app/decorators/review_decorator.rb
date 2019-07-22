class ReviewDecorator < Draper::Decorator
  delegate_all

  def user_initials
    user_full_name.split(' ').map(&:first).join.to_s
  end

  def user_full_name
    "#{user.billing_address.first_name} #{user.billing_address.last_name}"
  end
end
