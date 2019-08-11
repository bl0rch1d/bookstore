describe Checkout::Initialize do
  let(:result) { described_class.call(params) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_address_step, user: user) }

  describe 'Success' do
    let(:params) do
      {
        current_order: order,
        current_user: user,
        step: :address
      }
    end

    it do
      expect(result).to be_success

      expect(order.user_id).to eq(user.id)
    end
  end
end
