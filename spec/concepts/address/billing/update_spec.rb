describe Address::Billing::Update do
  let(:result) { described_class.call(params) }
  let(:user) { create(:user) }
  let(:addressable) { { addressable_type: 'User', addressable_id: user.id } }

  describe 'Success' do
    context 'when Operation' do
      context 'when billing address' do
        let(:params) do
          {
            user: {
              billing_address_attributes: attributes_for(:billing_address).merge(addressable)
            },

            current_user: user
          }
        end

        it do
          expect(result).to be_success
          expect(User.last.billing_address).to be_present
        end
      end
    end
  end

  describe 'Failure' do
    context 'when policy failed' do
      let(:invalid_addressable) { { addressable_type: 'User', addressable_id: create(:user).id } }

      let(:params) do
        {
          user: {
            billing_address_attributes: attributes_for(:billing_address).merge(invalid_addressable)
          },

          current_user: user
        }
      end

      it { expect(result).to be_failure }
    end

    context 'when invalid params' do
      let(:params) do
        {
          user: {
            billing_address_attributes: attributes_for(:book)
          },

          current_user: user
        }
      end

      it { expect(result).to be_failure }
    end
  end
end
