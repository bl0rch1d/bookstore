describe OrderItem::Index do
  let(:result) { described_class.call(order: current_order) }

  describe 'Success' do
    let(:current_order) { create(:order, :with_order_items) }

    it 'Return order items for current order' do
      expect(result['model'].sample).to be_a(OrderItem)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when order not specified' do
      let(:current_order) { nil }

      it do
        expect(result['model']).to eq(nil)
        expect(result).to be_failure
      end
    end
  end
end
