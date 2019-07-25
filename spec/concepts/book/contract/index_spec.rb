RSpec.describe Book::Contract::Index do
  let(:contract) { described_class.new(page: nil, sort_by: nil, category_id: nil) }

  describe 'Success' do
    let(:params) { { page: 3 } }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when page is not a number' do
      let(:params) { { page: 'dsad' } }
      let(:error) { ['Page is not a number'] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end

    context 'when page is negative' do
      let(:params) { { page: -2 } }
      let(:error) { ['Page must be greater than or equal to 1'] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end

    context 'when sort_by is invalid' do
      let(:params) { { page: 1, sort_by: 'dasdsadasd' } }
      let(:error) { ['Sort by is not included in the list'] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end
  end
end
