class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :billing_address
  decorates_association :shipping_address

  def full_name
    first_name = billing_address&.first_name || orders&.first&.billing_address&.first_name || email
    last_name = billing_address&.last_name || orders&.first&.billing_address&.last_name

    "#{first_name} #{last_name}".strip
  end

  def initials
    full_name.split(' ').map(&:first).join.to_s
  end
end
