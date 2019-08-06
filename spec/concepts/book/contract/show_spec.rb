RSpec.describe Book::Contract::Show do
  let(:contract) { described_class.new(id: nil) }

  describe 'Success' do
    let(:params) { { id: create(:book).id } }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when id is not present' do
      let(:params) { {} }
      let(:errors) { { id: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.not_a_number')] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(errors)
      end
    end

    context 'when id is not a number' do
      let(:params) { { id: 'ssss' } }
      let(:error) { { id: [I18n.t('errors.messages.not_a_number')] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(error)
      end
    end

    context 'when id is too small' do
      let(:params) { { id: 0 } }
      let(:error) { { id: [I18n.t('errors.messages.greater_than_or_equal_to', count: 1)] } }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to eq(error)
      end
    end
  end
end
