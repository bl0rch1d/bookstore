describe Checkout::Shipping::Edit do
  let(:result) { described_class.call(params.merge(step: :shipping)) }

  let(:user) { create :user }
  let(:shipping_method_id) { create(:shipping_method).id }

  describe 'Success' do
    let(:params) do
      {
        current_order: create(:order, :at_shipping_step, user: user),
        current_user: user
      }
    end

    it do
      create_list(:shipping_method, 10)

      expect(result['model']).to be_a(ActiveRecord::Relation)
      expect(result['model'].sample).to be_a(ShippingMethod)
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
  end
end
