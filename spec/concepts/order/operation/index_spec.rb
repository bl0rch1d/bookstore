describe Order::Index do
  subject(:result) { described_class.call(params) }

  let(:user) { create :user, orders: create_list(:order, 3, state: I18n.t('order.filter.in_delivery')) }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        user_id: user.id,
        sort_by: I18n.t('order.filter.in_delivery')
      }
    end

    it 'returns list of orders' do
      expect(result['model']).to be_a(ActiveRecord::Relation)

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          current_user: user,
          user_id: create(:user).id,
          sort_by: I18n.t('order.filter.in_delivery')
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure

        expect(result).to be_failure
      end
    end
  end
end
