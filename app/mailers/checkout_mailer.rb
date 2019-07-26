class CheckoutMailer < ApplicationMailer
  def order_check
    @user = params[:user]
    @order = params[:order]

    mail(to: @user.email, subject: 'Order check')
  end
end
