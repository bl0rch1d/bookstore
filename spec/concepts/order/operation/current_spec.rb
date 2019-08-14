describe Order::Current do
  let(:result) { described_class.call(params) }

  let(:order) { create(:order) }

  context 'when order does not exist' do
    let(:params) { { session: { current_order_id: nil } } }

    it 'creates order and set it to session' do
      expect(result['model']).to be_a(Order)
      expect(params[:session][:current_order_id]).to eq(Order.last.id)
    end
  end

  context 'when order exists' do
    let(:params) { { session: { current_order_id: order.id } } }

    it 'finds order and return it' do
      expect(result['model']).to be_a(Order)
      expect(result['model'].id).to eq(order.id)
    end
  end
end
