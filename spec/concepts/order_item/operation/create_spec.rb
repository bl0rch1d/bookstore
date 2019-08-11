describe OrderItem::Create do
  let(:result) { described_class.call(params) }

  let(:current_order) { create :order }
  let(:book) { create :book }

  describe 'Success' do
    let!(:model) { create(:order_item, book: book, order: current_order) }

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

    it "Creates order item via 'Buy Now' button or 'Add to cart' icon" do
      expect(result['model'].price).to eq(book.price)
      expect(result['model'].subtotal).to eq(book.price * result['model'].quantity)

      expect(result).to be_success
    end

    it "Creates order item via 'Add to card' form" do
      expect(result['model'].price).to eq(book.price)
      expect(result['model'].subtotal).to eq(book.price * params[:order_item][:quantity])

      expect(result).to be_success
    end

    context 'when order_item is already present' do
      let!(:book) { create(:book, price: 0.1393e3) }

      let(:params) do
        {
          order_item: {
            quantity: 4,
            book_id: book.id
          },

          order_id: model.order.id,
          current_order: current_order
        }
      end

      it do
        old_quantity = OrderItem.last.quantity
        form_quantity = params[:order_item][:quantity]

        described_class.call(params)

        expect(OrderItem.last.quantity - form_quantity).to eq(old_quantity)

        expect(result).to be_success
      end

      it 'updates subtotal' do
        result = described_class.call(params)

        expect(result['model'].price).to eq(book.price)
        expect(result['model'].subtotal).to eq(book.price * result['model'].quantity)

        expect(result).to be_success
      end
    end

    context 'when quantity is not a number' do
      let(:params) do
        {
          order_item: {
            quantity: 'dddddd',
            book_id: book.id
          },

          order_id: model.order.id,
          current_order: current_order
        }
      end

      it 'updates by 0' do
        old_quantity = OrderItem.last.quantity

        described_class.call(params)

        new_quantity = OrderItem.last.quantity

        expect(new_quantity).to eq(old_quantity)

        expect(result).to be_success
      end
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          order_item: {
            quantity: 4,
            book_id: book.id
          },

          order_id: create(:order).id,
          current_order: current_order
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end

    context 'when validation fails' do
      let(:params) do
        {
          order_item: {
            quantity: 101,
            book_id: book.id
          },

          order_id: current_order.id,
          current_order: current_order
        }
      end

      let(:error) { ['Quantity must be less than or equal to 100'] }

      it do
        expect(result['contract.default'].errors.full_messages).to eq(error)
        expect(result).to be_failure
      end
    end
  end
end
