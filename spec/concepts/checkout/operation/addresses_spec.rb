describe Checkout::Addresses do
  let(:present_result) { described_class::Present.call(params.merge(step: :address)) }
  let(:result) { described_class.call(params.merge(step: :address)) }

  let(:user) { create :user }

  let(:addressable_type) { 'Order' }

  describe 'Success' do
    context 'when Address::Present' do
      let(:params) do
        {
          current_order: create(:order, :at_address_step, user: user),
          current_user: user
        }
      end

      it do
        expect(present_result['billing_address_form']).to be_a(Address::Contract::Create)
        expect(present_result['shipping_address_form']).to be_a(Address::Contract::Create)
        expect(present_result).to be_success
      end
    end

    context 'when Address' do
      let!(:order) { create(:order, :at_address_step, user: user, state: I18n.t('order.filter.in_progress')) }

      let(:params) do
        {
          current_order: order,
          current_user: user,
          billing_address_params: ActionController::Parameters.new(
            attributes_for(:billing_address).merge(addressable_id: order.id, addressable_type: addressable_type)
          ),

          shipping_address_params: ActionController::Parameters.new(
            attributes_for(:shipping_address).merge(addressable_id: order.id, addressable_type: addressable_type)
          ),

          use_billing_address: false
        }
      end

      it 'Billing and Shipping' do
        expect(result).to be_success

        order.reload

        expect(order.billing_address).to be_a(BillingAddress)
        expect(order.shipping_address).to be_a(ShippingAddress)

        expect(order.billing_address.attributes).not_to eq(order.shipping_address.attributes)
      end

      context 'when use_billing' do
        let(:params) do
          {
            current_order: order,
            current_user: user,
            billing_address_params: ActionController::Parameters.new(attributes_for(:billing_address).merge(
              addressable_id: order.id, addressable_type: addressable_type
            ).except(:type)),

            use_billing_address: true
          }
        end

        it 'Shipping with billing_address attributes' do
          expect(result).to be_success

          order.reload

          expect(order.billing_address).to be_a(BillingAddress)
          expect(order.shipping_address).to be_a(ShippingAddress)

          billing_params = order.billing_address.attributes.except('created_at', 'id', 'type', 'updated_at')
          shipping_params = order.shipping_address.attributes.except('created_at', 'id', 'type', 'updated_at')

          expect(billing_params).to eq(shipping_params)
        end
      end
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      context 'when checkout policy fails' do
        let(:order) { create(:order, user: user) }

        let(:params) do
          {
            current_order: order,
            current_user: user,
            billing_address_params: ActionController::Parameters.new(attributes_for(:billing_address)),
            shipping_address_params: ActionController::Parameters.new(attributes_for(:shipping_address)),
            use_billing_address: false
          }
        end

        it do
          expect(result['result.policy.checkout']).to be_failure
          expect(result).to be_failure
        end
      end

      context 'when user policy fails' do
        let(:order) { create(:order, :at_address_step, user: user) }

        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            billing_address_params: ActionController::Parameters.new(attributes_for(:billing_address)),
            shipping_address_params: ActionController::Parameters.new(attributes_for(:shipping_address)),
            use_billing_address: false
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end
    end

    context 'when invalid params' do
      let(:order) { create(:order, :at_address_step, user: user) }

      let(:params) do
        {
          current_order: order,
          current_user: user,
          billing_address_params: ActionController::Parameters.new(attributes_for(:user)),
          shipping_address_params: ActionController::Parameters.new(attributes_for(:book)),
          use_billing_address: false
        }
      end

      it { expect(result).to be_failure }

      it 'resutrns contracts with errors' do
        expect(result['billing_address_form'].errors.messages).to be_any
        expect(result['shipping_address_form'].errors.messages).to be_any

        expect(result).to be_failure
      end
    end
  end
end
