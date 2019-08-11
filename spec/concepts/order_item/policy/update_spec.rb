describe OrderItem::Policy::UpdateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:current_order) { create(:order, :at_address_step) }
  let(:book) { create(:book) }

  describe 'Success' do
    let(:params) do
      {
        current_order: current_order,
        order_id: current_order.id,
        id: current_order.order_items.first.id
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when order_id not equal to current_orde.id' do
      let(:params) do
        {
          current_order: current_order,
          order_id: 99,
          id: current_order.order_items.first.id
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when order_item not owner by current_order' do
      let(:params) do
        {
          current_order: current_order,
          order_id: current_order.id,
          id: 43
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
