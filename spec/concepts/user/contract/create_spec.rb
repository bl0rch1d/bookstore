RSpec.describe User::Contract::Create do
  let(:contract) { described_class.new(User.new) }

  describe 'Success' do
    let(:user_params) { attributes_for(:user) }

    it { expect(contract.validate(user_params)).to be_truthy }
  end

  describe 'Failure' do
    let(:user_params) { attributes_for(:book) }

    context 'when user params invalid' do
      let(:errors) do
        {
          email: ["can't be blank", 'is invalid'],
          password: ["can't be blank", 'is too short (minimum is 8 characters)']
        }
      end

      it 'fails' do
        expect(contract.validate(user_params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
