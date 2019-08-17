describe CheckoutStep::Shipping do
  let(:present_result) { described_class::Present.call(params.merge(step: :shipping)) }
  let(:result) { described_class.call(params.merge(step: :shipping)) }

  let(:user) { create :user }

  describe 'Success' do
    context 'when Shipping::Present' do
      let(:params) do
        {
          current_order: create(:order, :at_shipping_step, user: user),
          current_user: user
        }
      end

      it do
        create_list(:shipping_method, 10)

        expect(present_result['model']).to be_a(ActiveRecord::Relation)
        expect(present_result['model'].sample).to be_a(ShippingMethod)
        expect(present_result).to be_success
      end
    end

    context 'when Shipping' do
      let(:order) { create(:order, :at_shipping_step, user: user) }

      let(:params) do
        {
          current_order: order,
          current_user: user,
          shipping_method_id: create(:shipping_method).id
        }
      end

      it do
        expect(result['model']).to be_a(ShippingMethod)
        expect(order.shipping_method).to be_present
        expect(result).to be_success
      end
    end
  end

  describe 'Failure' do
    let(:order) { create(:order, :at_shipping_step, user: user) }

    context 'when policy fails' do
      context 'when checkout policy fails' do
        let(:order) { create(:order, user: user) }

        let(:params) do
          {
            current_order: order,
            current_user: user,
            shipping_method_id: create(:shipping_method).id
          }
        end

        it do
          expect(result['result.policy.checkout']).to be_failure
          expect(result).to be_failure
        end
      end

      context 'when user policy fails' do
        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            shipping_method_id: create(:shipping_method).id
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end

      context 'when step policy fails' do
        let(:params) do
          {
            current_order: create(:order, :at_address_step, user: user),
            current_user: user,
            shipping_method_id: create(:shipping_method).id
          }
        end

        it do
          expect(result['result.policy.step']).to be_failure
          expect(result).to be_failure
        end
      end
    end

    context 'when shipping method not found' do
      let(:params) do
        {
          current_order: order,
          current_user: create(:user),
          shipping_method_id: 'sd'
        }
      end

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end
  end
end
