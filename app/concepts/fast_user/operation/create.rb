class FastUser::Create < Trailblazer::Operation
  step Model(User, :new)
  step Contract::Build(constant: FastUser::Contract::Create)
  step Contract::Validate(), fail_fast: true
  step Contract::Persist()
  step :mail

  def mail(ctx, params:, **)
    FastRegistrationMailer.temporary_password(ctx['model'].id, params[:password]).deliver_later
  end
end
