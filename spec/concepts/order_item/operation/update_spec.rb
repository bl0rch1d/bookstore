describe OrderItem::Update do
  let(:result) { described_class.call(params) }

  let(:current_order) { create :order }
  let(:book) { create(:book, price: 0.303e2) }
  let!(:order_item) { create(:order_item, book: book, price: book.price, order: current_order) }

  describe 'Success' do
    [1, -1, 3, 4, 5].each do |quantity|
      it 'correct price and subtotal' do
        old_quantity = OrderItem.last.quantity

        result = described_class.call(current_order: current_order,
                                      order_id: current_order.id,
                                      id: order_item.id,
                                      order_item: { quantity: quantity })

        expect(result).to be_success

        expect(OrderItem.last.quantity - quantity).to eq(old_quantity)
        expect(OrderItem.last.price).to eq(OrderItem.last.book.price)
        expect(OrderItem.last.subtotal).to eq(OrderItem.last.price * (old_quantity + quantity))
      end
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          current_order: current_order,
          order_id: 3233,
          id: 323,
          order_item: { quantity: 1 }
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end

    context 'when id is invalid' do
      let(:params) do
        {
          current_order: current_order,
          order_id: current_order.id,
          id: 323,
          order_item: { quantity: 1 }
        }
      end

      it do
        expect(result['model']).to eq(nil)
        expect(result).to be_failure
      end
    end

    context 'when invalid params' do
      let(:params) do
        {
          current_order: current_order,
          order_id: current_order.id,
          id: order_item.id,
          order_item: { quantity: 101 }
        }
      end

      let(:error) do
        [
          I18n.t(
            'errors.format',
            attribute: :Quantity,
            message: I18n.t('errors.messages.less_than_or_equal_to', count: 100)
          )
        ]
      end

      it do
        expect(result['contract.default'].errors.full_messages).to eq(error)
        expect(result).to be_failure
      end
    end
  end
end
