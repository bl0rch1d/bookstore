describe OrderItem::Destroy do
  let(:result) { described_class.call(params) }

  let!(:current_order) { create(:order, :at_address_step) }

  describe 'Success' do
    let(:params) do
      {
        current_order: current_order,
        order_id: current_order.id,
        id: current_order.order_items.first.id
      }
    end

    it 'Removes order item' do
      expect { result }.to change { Order.last.order_items.size }.by(-1)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          current_order: current_order,
          order_id: current_order.id,
          id: 343
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
