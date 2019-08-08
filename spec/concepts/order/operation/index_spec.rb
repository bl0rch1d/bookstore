RSpec.describe Order::Index do
  subject(:result) { described_class.call(params, 'current_user' => user) }

  describe 'Success' do
    let(:params) { { sort_by: I18n.t('order.filter.delivered') } }
    let(:user) { create :user, :with_orders }

    it 'returns list of orders' do
      expect(result['model']).to be_a(ActiveRecord::Relation)

      expect(result).to be_success
    end
  end
end
