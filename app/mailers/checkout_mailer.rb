class CheckoutMailer < ApplicationMailer
  def complete(user_id, order_id)
    @user = User.find_by(id: user_id)
    @order = @user.orders.where(id: order_id).first.decorate

    mail(
      to: @user.email,
      subject: I18n.t('order.mailer.subject', order_number: @order.number, user: @user)
    )
  end
end
