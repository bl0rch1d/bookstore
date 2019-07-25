RSpec.describe Order::Contract::Show do
  let(:contract) { described_class.new(id: nil) }

  describe 'Success' do
    let(:params) { { id: 3 } }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when id not a number' do
      let(:params) { { id: 'dsd' } }
      let(:error) { ['Id is not a number'] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq(error)
      end
    end
  end
end
