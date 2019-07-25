RSpec.describe OrderItem::Create do
  let(:result) { described_class.call(params) }

  let(:current_order) { create :order }
  let(:book) { create :book }

  describe 'Success' do
    let(:params) do
      {
        book_id: book.id,
        order_id: current_order.id
      }
    end

    let(:order_item_form) { { order_item: { quantity: 5 } } }

    it "Creates order item via 'Buy Now' button and 'Add to cart' icon" do
      expect(result['model']).to be_a(OrderItem)
      expect(result['model'].order_id).to eq(current_order.id)

      expect(result['model'].price).to eq(book.price)
      expect(result['model'].subtotal).to eq(book.price * result['model'].quantity)

      expect(result).to be_success
    end

    it "Creates order item via 'Add to card' form" do
      params.merge!(order_item_form)

      expect(result['model']).to be_a(OrderItem)
      expect(result['model'].order_id).to eq(current_order.id)

      expect(result['model'].price).to eq(book.price)
      expect(result['model'].subtotal).to eq(book.price * params[:order_item][:quantity])

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when book_id and order_id not present' do
      let(:params) { {} }

      it do
        expect(result['model']).to eq(nil)
        expect(result).to be_failure
      end
    end
  end
end
