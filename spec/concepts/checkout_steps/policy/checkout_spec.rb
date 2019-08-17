describe CheckoutStep::Policy::CheckoutGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        current_order: create(:order, :at_address_step, user: user),
        step: :address
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    let(:params) do
      {
        current_user: user,
        current_order: create(:order, user: user),
        step: :address
      }
    end

    it { expect(result).to be_falsey }
  end
end
