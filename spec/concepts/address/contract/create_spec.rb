RSpec.describe Address::Contract::Create do
  let(:contract) { described_class.new(Address.new) }

  describe 'Success' do
    let(:params) { attributes_for(:billing_address, :for_user) }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    let(:params) { attributes_for(:user) }

    context 'when address params invalid' do
      let(:errors) do
        {
          first_name: ["can't be blank", 'is invalid'],
          last_name: ["can't be blank", 'is invalid'],
          address_line: ["can't be blank", 'is invalid'],
          city: ["can't be blank", 'is invalid'],
          country: ["can't be blank", 'is invalid'],
          zip: ["can't be blank", 'is invalid'],
          phone: ["can't be blank", 'is invalid']
        }
      end

      it 'fails' do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
