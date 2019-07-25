RSpec.describe OrderItem::Update do
  let(:result) { described_class.call(id: id, quantity: quantity) }

  let(:order_item) { create :order_item }

  describe 'Success' do
    let(:quantity) { 3 }
    let(:id) { order_item.id }

    it 'updates order item' do
      expect(result['model']).to be_a(OrderItem)
      expect(result['contract.default'].errors.full_messages).to be_empty

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when id is invalid' do
      let(:quantity) { 2 }
      let(:id) { 'dsadad' }

      it do
        expect(result['model']).to eq(nil)
        expect(result).to be_failure
      end
    end

    context 'when quantity is too big' do
      let(:quantity) { 200 }
      let(:id) { order_item.id }

      let(:error) { ['Quantity must be less than or equal to 100'] }

      it do
        expect(result['contract.default'].errors.full_messages).to eq(error)
        expect(result).to be_failure
      end
    end
  end
end
