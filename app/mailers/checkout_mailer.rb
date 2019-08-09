class CheckoutMailer < ApplicationMailer
  def complete(user, order)
    @user = user
    @order = order.decorate

    mail(to: @user.email, subject: I18n.t('order.mailer.subject', order_number: @order.number, user: @user))
  end
end
