RSpec.describe OrderItem::Delete do
  let(:result) { described_class.call(id: order_item_id) }

  describe 'Success' do
    let(:order_item_id) { create(:order_item).id }

    it 'Removes order item' do
      expect(result['model']).to be_a(OrderItem)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when order item not found' do
      let(:order_item_id) { 999_999 }

      it do
        expect(result['model']).to eq(nil)
        expect(result).to be_failure
      end
    end
  end
end
