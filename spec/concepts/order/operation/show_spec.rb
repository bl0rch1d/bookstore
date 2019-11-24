describe Order::Show do
  let(:result) { described_class.call(params) }

  let(:user) { create :user, :with_orders }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        user_id: user.id,
        id: user.orders.completed.first.id
      }
    end

    it 'returns order' do
      expect(result['model']).to be_a(Order)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          current_user: nil,
          user_id: user.id,
          id: user.orders.completed.first.id
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
