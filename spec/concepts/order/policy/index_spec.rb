describe Order::Policy::IndexGuard do
  let(:result) { described_class.new.call(nil, params: params) }
  let(:user) { create :user, :with_orders }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        user_id: user.orders.sample.user_id
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when current user is nil' do
      let(:params) do
        {
          current_user: nil,
          user_id: user.orders.sample.user_id
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when invalid user_id' do
      let(:params) do
        {
          current_user: user,
          user_id: 'dsdsd'
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
