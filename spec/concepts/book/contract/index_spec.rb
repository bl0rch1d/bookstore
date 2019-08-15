describe Book::Contract::Index do
  let(:contract) { described_class.new(page: nil, sort_by: nil, category_id: nil) }

  describe 'Success' do
    let(:params) { { page: 3 } }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when page is not a number' do
      let(:params) { { page: 'dsad' } }
      let(:error) { [I18n.t('errors.format', attribute: :Page, message: I18n.t('errors.messages.not_a_number'))] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end

    context 'when page is negative' do
      let(:params) { { page: -2 } }
      let(:error) do
        [
          I18n.t('errors.format',
                 attribute: :Page,
                 message: I18n.t('errors.messages.greater_than_or_equal_to', count: described_class::MIN_PAGE_VALUE))
        ]
      end

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end

    context 'when sort_by is invalid' do
      let(:params) { { page: 1, sort_by: 'dasdsadasd' } }
      let(:error) { [I18n.t('errors.format', attribute: :"Sort by", message: I18n.t('errors.messages.inclusion'))] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq error
      end
    end
  end
end
