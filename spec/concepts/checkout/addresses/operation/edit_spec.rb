describe Checkout::Addresses::Edit do
  let(:result) { described_class.call(params.merge(step: :address)) }

  let(:user) { create :user }

  let(:addressable) { { addressable_id: order.id, addressable_type: 'Order' } }

  describe 'Success' do
    let(:params) do
      {
        current_order: create(:order, :at_address_step, user: user),
        current_user: user
      }
    end

    it do
      expect(result['billing_address_form']).to be_a(Address::Contract::Create)
      expect(result['shipping_address_form']).to be_a(Address::Contract::Create)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      context 'when user policy fails' do
        let(:order) { create(:order, :at_address_step, user: user) }

        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            order: {
              billing_address: ActionController::Parameters.new(attributes_for(:billing_address)),
              shipping_address: ActionController::Parameters.new(attributes_for(:shipping_address)),
              use_billing: false
            }
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end
    end
  end
end
