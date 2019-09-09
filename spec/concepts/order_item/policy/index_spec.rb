describe OrderItem::Policy::IndexGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:current_order) { create(:order) }
  let(:book) { create(:book) }

  describe 'Success' do
    let(:params) do
      {
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
          order_id: 323,
          current_order: current_order
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
