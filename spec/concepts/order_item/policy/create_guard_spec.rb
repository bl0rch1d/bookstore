RSpec.describe OrderItem::Policy::CreateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  describe 'Success' do
    let(:params) do
      { order_item: {
        book_id: create(:book).id,
        order_id: create(:order).id
      } }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when order not exists' do
      let(:params) do
        { order_item: {
          book_id: create(:book).id
        } }
      end

      it { expect(result).to be_falsey }
    end

    context 'when book not exists' do
      let(:params) do
        { order_item: {
          order_id: create(:order).id
        } }
      end

      it { expect(result).to be_falsey }
    end
  end
end
