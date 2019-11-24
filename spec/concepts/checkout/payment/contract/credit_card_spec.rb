describe Checkout::Payment::Contract::CreditCard do
  let(:contract) { described_class.new(CreditCard.new) }

  describe 'Success' do
    let(:params) { ActionController::Parameters.new(attributes_for(:credit_card)) }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    let(:params) { ActionController::Parameters.new(attributes_for(:user)) }

    context 'when credit_card params invalid' do
      let(:errors) do
        {
          card_name: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          number: [
            I18n.t('errors.messages.blank'),
            I18n.t('errors.messages.invalid'),
            I18n.t('errors.messages.too_short.other', count: described_class::NUMBER_RANGE.first)
          ],
          cvv: [
            I18n.t('errors.messages.blank'),
            I18n.t('errors.messages.too_short.other', count: described_class::CVV_RANGE.first)
          ],

          expiration_date: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          order_id: [I18n.t('errors.messages.not_a_number')]
        }
      end

      it 'fails' do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end

    context 'when expiration date validation' do
      let(:invalid_expiration_date) { 'dsdsd' }
      let(:expired_expiration_date) { '12/12' }

      let(:params) { ActionController::Parameters.new(attributes_for(:credit_card)) }

      let(:invalid_error) { { expiration_date: [I18n.t('errors.messages.invalid')] } }
      let(:expired_error) { { expiration_date: [I18n.t('validation_errors.credit_card.expired')] } }

      it do
        params[:expiration_date] = invalid_expiration_date

        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match invalid_error
      end

      it do
        params[:expiration_date] = expired_expiration_date

        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match expired_error
      end
    end
  end
end
