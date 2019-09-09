describe Review::Contract::Create do
  let(:contract) { described_class.new(Review.new) }

  describe 'Success' do
    let(:review_params) { attributes_for(:review) }

    it { expect(contract.validate(review_params)).to be_truthy }
  end

  describe 'Failure' do
    let(:review_params) { attributes_for(:user) }

    context 'when review params invalid' do
      let(:errors) do
        {
          title: [I18n.t('errors.messages.blank')],
          body: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          rating: [
            I18n.t('errors.messages.blank'),
            I18n.t('errors.messages.invalid'),
            I18n.t('errors.messages.not_a_number'),
            I18n.t('errors.messages.inclusion')
          ]
        }
      end

      it 'fails' do
        expect(contract.validate(review_params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
