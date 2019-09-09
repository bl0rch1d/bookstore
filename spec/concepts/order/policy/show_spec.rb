describe Order::Policy::ShowGuard do
  let(:result) { described_class.new.call(nil, params: params) }
  let(:user) { create(:user, :with_orders) }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        user_id: user.id,
        id: user.orders.first.id
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when invalid user_id' do
      let(:params) do
        {
          current_user: user,
          user_id: 'dsd',
          id: user.orders.first.id
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when invalid id' do
      let(:params) do
        {
          current_user: user,
          user_id: user.id,
          id: 'sss'
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when order not owner by current_user' do
      let(:params) do
        {
          current_user: create(:user),
          user_id: user.id,
          id: user.orders.first.id
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
