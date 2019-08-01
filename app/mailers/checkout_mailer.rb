class CheckoutMailer < ApplicationMailer
  def complete(user, order)
    @user = user
    @order = order.decorate

    mail(to: @user.email, subject: "Complete Order ##{@order.number}")
  end
end
