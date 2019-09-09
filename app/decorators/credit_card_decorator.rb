class CreditCardDecorator < Draper::Decorator
  delegate_all

  def secure_number
    "#{Array.new(3) { '**' }.join(' ')} #{number&.last(4)}"
  end
end
