describe Order::Policy::ShowPolicy do
  let(:policy) { described_class.new(user, record) }

  describe 'Success' do
    let(:user) { create :user, :with_orders }
    let(:record) { user.orders.sample }

    it { expect(policy).to be_show }
  end

  describe 'Failure' do
    context 'when user is not present' do
      let(:user) { {} }
      let(:record) { {} }

      it { expect(policy).not_to be_show }
    end

    context 'when record not belongs to user' do
      let(:user) { create :user, :with_orders }
      let(:record) { create :order }

      it { expect(policy).not_to be_show }
    end
  end
end
