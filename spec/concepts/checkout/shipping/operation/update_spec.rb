describe Checkout::Shipping::Update do
  let(:result) { described_class.call(params.merge(step: :shipping)) }

  let(:user) { create :user }
  let(:shipping_method_id) { create(:shipping_method).id }

  describe 'Success' do
    let(:order) { create(:order, :at_shipping_step, user: user) }

    let(:params) do
      {
        current_order: order,
        current_user: user,
        order: {
          shipping_method_id: shipping_method_id
        }
      }
    end

    it do
      expect(result['model']).to be_a(ShippingMethod)
      expect(order.shipping_method).to be_present
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    let(:order) { create(:order, :at_shipping_step, user: user) }

    context 'when policy fails' do
      context 'when user policy fails' do
        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            order: {
              shipping_method_id: shipping_method_id
            }
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end
    end

    context 'when shipping method not found' do
      let(:params) do
        {
          current_order: order,
          current_user: create(:user),
          order: {
            shipping_method_id: 'ss'
          }
        }
      end

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end
  end
end
