# Preview all emails at http://localhost:3000/rails/mailers/checkout_mailer
class CheckoutMailerPreview < ActionMailer::Preview
  def complete
    CheckoutMailer.complete(User.last, Order.last)
  end
end
