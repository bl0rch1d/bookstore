describe Address::Policy::UpdateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  context 'when user authenticated' do
    context 'when addressable points to current_user' do
      context 'when billing_address' do
        let(:params) do
          {
            current_user: user,
            user: {
              billing_address_attributes: attributes_for(:billing_address,
                                                         addressable_id: user.id,
                                                         addressable_type: 'User')
            }
          }
        end

        it { expect(result).to be_truthy }
      end

      context 'when shipping_address' do
        let(:params) do
          {
            current_user: user,
            user: {
              shipping_address_attributes: attributes_for(:shipping_address,
                                                          addressable_id: user.id,
                                                          addressable_type: 'User')
            }
          }
        end

        it { expect(result).to be_truthy }
      end
    end

    context 'when addressable invalid' do
      let(:params) do
        {
          current_user: user,
          user: {
            shipping_address_attributes: attributes_for(:shipping_address,
                                                        addressable_id: create(:user).id,
                                                        addressable_type: 'User')
          }
        }
      end

      it { expect(result).to be_falsey }
    end
  end

  context 'when user not authenticated' do
    let(:params) do
      {
        current_user: nil,
        user: {
          shipping_address_attributes: attributes_for(:shipping_address,
                                                      addressable_id: create(:user).id,
                                                      addressable_type: 'User')
        }
      }
    end

    it { expect(result).to be_falsey }
  end
end
