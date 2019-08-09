describe OrderItem::Delete do
  let(:result) { described_class.call(id: order_item_id) }

  describe 'Success' do
    # rubocop: disable RSpec/LetSetup
    let!(:order_item_id) { create(:order, :with_order_items).order_items.first.id }
    # rubocop: enable RSpec/LetSetup

    it 'Removes order item' do
      expect { result }.to change { Order.last.order_items.size }.by(-1)

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
