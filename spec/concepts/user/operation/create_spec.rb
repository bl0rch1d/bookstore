# class User::Create < Trailblazer::Operation
#   step Model(User, :new)
#   step Contract::Build(constant: User::Contract::Create)
#   step Contract::Validate()
#   step Contract::Persist()
#   step :mail

#   def mail(ctx, params:, **)
#     FastRegistrationMailer.temporary_password(ctx['model'], params[:password]).deliver_later
#   end
# end

RSpec.describe User::Create do
  let(:result) { described_class.call(user_params) }

  describe 'Success' do
    let(:user_params) { attributes_for(:user) }

    it 'Creates a User' do
      expect(result['model']).to be_a(User)
      expect(result['result.contract.default']).to be_success
      expect(User.last.email).to eq(user_params[:email])

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    let(:user_params) { attributes_for(:book) }

    context 'when params invalid' do
      it { expect(result).to be_failure }
    end
  end
end
