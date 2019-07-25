RSpec.describe Order::Index do
  subject(:result) { described_class.call(params, 'current_user' => user) }

  describe 'Success' do
    let(:params) { { sort_by: 'delivered' } }
    let(:user) { create :user, :with_orders }

    it 'returns list of orders' do
      expect(result['model']).to be_a(ActiveRecord::Relation)

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when invalid parameters' do
      let(:user) { create :user, :with_orders }
      let(:params) { { sort_by: 23 } }

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end
  end
end
