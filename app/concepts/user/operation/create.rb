class User::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: User::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()
  step :mail

  def mail(ctx, params:, **)
    FastRegistrationMailer.temporary_password(ctx['model'], params[:password]).deliver_later
  end
end
