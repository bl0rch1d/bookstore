describe Address::Contract::Create do
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
          first_name: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          last_name: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          address_line: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          city: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          country: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          zip: [I18n.t('errors.messages.blank'), I18n.t('errors.messages.invalid')],
          phone:
          [
            I18n.t('errors.messages.blank'),
            I18n.t('errors.messages.too_short.other', count: described_class::PHONE_LENGTH_RANGE.min),
            I18n.t('errors.messages.invalid')
          ]
        }
      end

      it 'fails' do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.messages).to match errors
      end
    end
  end
end
