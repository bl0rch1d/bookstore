describe Address::Edit do
  let(:result) { described_class.call(params) }
  let(:user) { create(:user) }
  let(:addressable) { { addressable_type: 'User', addressable_id: user.id } }

  describe 'Success' do
    let(:params) do
      {
        user: {
          billing_address_attributes: attributes_for(:billing_address).merge(addressable),
          shipping_address_attributes: attributes_for(:shipping_address).merge(addressable)
        },

        current_user: user
      }
    end

    it 'creates forms' do
      expect(result['billing_address_form']).to be_a(Address::Contract::Create)
      expect(result['shipping_address_form']).to be_a(Address::Contract::Create)

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    let(:params) { { current_user: nil } }

    it 'policy' do
      expect(result).to be_failure
    end
  end
end
