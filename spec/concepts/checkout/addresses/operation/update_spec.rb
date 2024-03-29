describe Checkout::Addresses::Update do
  let(:result) { described_class.call(params.merge(step: :address)) }

  let(:user) { create :user }

  let(:addressable) { { addressable_id: order.id, addressable_type: 'Order' } }

  describe 'Success' do
    let!(:order) { create(:order, :at_address_step, user: user, state: I18n.t('order.filter.in_progress')) }

    let(:params) do
      {
        current_order: order,
        current_user: user,
        order: {
          billing_address: ActionController::Parameters.new(
            attributes_for(:billing_address).merge(addressable)
          ),

          shipping_address: ActionController::Parameters.new(
            attributes_for(:shipping_address).merge(addressable)
          ),
          use_billing: 'false'
        }
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
          order: {
            billing_address: ActionController::Parameters.new(
              attributes_for(:billing_address).except(:type).merge(addressable)
            ),
            use_billing: 'true'
          }
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

    context 'when user has addresses' do
      let(:user) { create(:user, :with_addresses) }

      context 'when user uses his addresess' do
        let(:billing_address_attributes) do
          user.billing_address.attributes
              .except('id', 'created_at', 'updated_at', 'type')
              .merge(addressable)
        end

        let(:shipping_address_attributes) do
          user.shipping_address.attributes
              .except('id', 'created_at', 'updated_at', 'type')
              .merge(addressable)
        end

        let(:params) do
          {
            current_order: order,
            current_user: user,
            order: {
              billing_address: ActionController::Parameters.new(billing_address_attributes),
              shipping_address: ActionController::Parameters.new(shipping_address_attributes),
              use_billing: 'false'
            }
          }
        end

        it 'copy user addresses and set as order addresses' do
          expect(result).to be_success

          order.reload

          expect(order.billing_address).to be_a(BillingAddress)
          expect(order.shipping_address).to be_a(ShippingAddress)

          expect(user.billing_address).to be_a(BillingAddress)
          expect(user.shipping_address).to be_a(ShippingAddress)
        end
      end

      context 'when user enters another addresses' do
        let(:params) do
          {
            current_order: order,
            current_user: user,
            order: {
              billing_address: ActionController::Parameters.new(
                attributes_for(:billing_address).merge(addressable)
              ),

              shipping_address: ActionController::Parameters.new(
                attributes_for(:shipping_address).merge(addressable)
              ),

              use_billing: 'false'
            }
          }
        end

        it 'setup new order addresess' do
          expect(result).to be_success

          order.reload

          expect(order.billing_address).to be_a(BillingAddress)
          expect(order.shipping_address).to be_a(ShippingAddress)
        end
      end
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
              use_billing: 'false'
            }
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
          order: {
            billing_address: ActionController::Parameters.new(attributes_for(:user)),
            shipping_address: ActionController::Parameters.new(attributes_for(:book)),
            use_billing: 'false'
          }
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
