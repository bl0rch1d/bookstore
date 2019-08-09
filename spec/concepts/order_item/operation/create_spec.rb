describe OrderItem::Create do
  let(:result) { described_class.call(params) }

  let(:current_order) { create :order }
  let(:book) { create :book }

  describe 'Success' do
    let(:params) do
      { order_item: {
        quantity: 5,
        book_id: book.id,
        order_id: current_order.id
      } }
    end

    it "Creates order item via 'Buy Now' button and 'Add to cart' icon" do
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

      let!(:model) { create(:order_item, book: book) }

      let(:params) do
        { order_item: {
          quantity: 4.0,
          book_id: book.id,
          order_id: model.order.id
        } }
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
      let!(:model) { create :order_item }

      let(:params) do
        { order_item: {
          quantity: 'dddddd',
          subtotal: 1.0,
          price: 1.0,
          book_id: model.book.id,
          order_id: model.order.id
        } }
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
    context 'when book_id and order_id not present' do
      let(:params) { {} }

      it do
        expect(result['result.policy.default']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
