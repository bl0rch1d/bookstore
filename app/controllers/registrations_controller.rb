class RegistrationsController < Devise::RegistrationsController
  def fast_new
    @customer = Customer.new
  end

  def fast_create
    generated_password = Devise.friendly_token.first(8)

    @customer = Customer.new(email: params[:customer][:email], password: generated_password)

    if @customer.save
      sign_up(:customer, @customer)

      redirect_to checkout_path
    else
      render 'devise/registrations/fast_new'
    end
  end
end
