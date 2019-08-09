describe Checkout::Shipping do
  let(:user) { create :user }

  describe 'Success' do
    context 'when Shipping::Present' do
      let(:result) { described_class::Present.call(params) }

      let(:params) do
        {
          'current_order' => create(:order, :at_shipping_step, user: user),
          'current_user' => user,
          'step' => :shipping
        }
      end

      it do
        create_list(:shipping_method, 10)

        expect(result['model']).to be_a(ActiveRecord::Relation)
        expect(result['model'].sample).to be_a(ShippingMethod)
        expect(result).to be_success
      end
    end

    context 'when Shipping' do
      let(:result) { described_class.call(params) }

      let(:order) { create(:order, :at_shipping_step, user: user) }

      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :shipping,
          'shipping_method_id' => create(:shipping_method).id
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
    let(:result) { described_class.call(params) }

    let(:order) { create(:order, :at_shipping_step, user: user) }

    context 'when policy fails' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => create(:user),
          'step' => :shipping
        }
      end

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end

    context 'when shipping method not found' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :shipping,
          'shipping_method_id' => 'sd'
        }
      end

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end
  end
end
