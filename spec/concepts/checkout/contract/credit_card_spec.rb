RSpec.describe Checkout::Contract::CreditCard do
  let(:contract) { described_class.new(CreditCard.new) }

  describe 'Success' do
    let(:params) { attributes_for(:credit_card) }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    let(:params) { attributes_for(:user) }

    context 'when address params invalid' do
      let(:errors) do
        {
          card_name: ["can't be blank", 'is invalid'],
          number: ["can't be blank", 'is invalid'],
          cvv: ["can't be blank", 'is too short (minimum is 3 characters)'],
          expiration_date: ["can't be blank", 'is invalid'],
        }
      end

      it 'fails' do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
