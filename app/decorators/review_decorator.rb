class ReviewDecorator < Draper::Decorator
  delegate_all

  def user_initials
    user_full_name.split(' ').map(&:first).join.to_s
  end

  def user_full_name
    first_name = user.billing_address&.first_name || user.orders&.first&.billing_address&.first_name || user.email
    last_name = user.billing_address&.last_name || user.orders&.first&.billing_address&.last_name

    "#{first_name} #{last_name}".strip
  end
end
