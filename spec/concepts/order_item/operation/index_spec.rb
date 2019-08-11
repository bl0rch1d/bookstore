describe OrderItem::Index do
  let(:result) { described_class.call(params) }

  let(:current_order) { create(:order, :at_address_step) }

  describe 'Success' do
    let(:params) do
      {
        order_id: current_order.id,
        current_order: current_order
      }
    end

    it 'Return order items for current order' do
      expect(result['model'].sample).to be_a(OrderItem)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          order_id: 343,
          current_order: current_order
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
