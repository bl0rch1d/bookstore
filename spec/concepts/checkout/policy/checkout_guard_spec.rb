RSpec.describe Checkout::Policy::CheckoutGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  describe 'Success' do
    context 'when address' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :with_order_items, user: user),
          'step' => :address
        }
      end

      it { expect(result).to be_truthy }
    end

    context 'when shipping' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :full, user: user),
          'step' => :shipping
        }
      end

      it { expect(result).to be_truthy }
    end

    context 'when payment' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :full, user: user),
          'step' => :payment
        }
      end

      it { expect(result).to be_truthy }
    end

    context 'when confirm' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :full, user: user),
          'step' => :confirm
        }
      end

      it { expect(result).to be_truthy }
    end

    context 'when complete' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :full, user: user),
          'step' => :complete
        }
      end

      it { expect(result).to be_truthy }
    end
  end

  describe 'Failure' do
    context 'when order is not owned by current_user' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, :full, user: create(:user)),
          'step' => :address
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when cart is empty' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, user: user),
          'step' => :address
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when step is not allowed' do
      let(:params) do
        {
          'current_user' => user,
          'current_order' => create(:order, user: user),
          'step' => :payment
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
