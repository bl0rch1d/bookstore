RSpec.describe Order::Show do
  let(:result) { described_class.call(params, 'current_user' => user) }

  describe 'Success' do
    let(:user) { create :user, :with_orders }
    let(:params) { { id: user.orders.sample.id } }

    it 'returns order' do
      expect(result['model']).to be_a(Order)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when id is invalid' do
      let(:user) { create :user, :with_orders }
      let(:params) { { id: 'sdsdd' } }

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end

    context 'when policy failed' do
      let(:another_user) { create :user, :with_orders }

      let(:user) { create :user, :with_orders }
      let(:params) { { id: another_user.orders.sample.id } }

      it do
        expect(result['policy.default']).not_to be_show
        expect(result).to be_failure
      end
    end
  end
end
