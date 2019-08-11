describe OrderItem::Policy::CreateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:current_order) { create :order }
  let(:book) { create :book }

  describe 'Success' do
    let(:params) do
      {
        order_item: {
          quantity: 5,
          book_id: book.id
        },

        order_id: current_order.id,
        current_order: current_order
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when order_id not equal to current_order.id' do
      let(:params) do
        {
          order_item: {
            quantity: 5,
            book_id: book.id
          },

          order_id: 34,
          current_order: current_order
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when book not exists' do
      let(:params) do
        {
          order_item: {
            quantity: 5,
            book_id: 444
          },

          order_id: 34,
          current_order: current_order
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
