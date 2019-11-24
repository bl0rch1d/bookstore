class AddressDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{first_name} #{last_name}"
  end

  def city_zip
    "#{city} #{zip}"
  end
end
