describe CheckoutStep::Policy::StepGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  context 'when shipping' do
    let(:params) do
      {
        current_user: user,
        current_order: order,
        step: :shipping
      }
    end

    context 'when success' do
      let(:order) { create(:order, :at_shipping_step, user: user) }

      it { expect(result).to be_truthy }
    end

    context 'when failure' do
      let(:order) { create(:order, :at_address_step, user: user) }

      it { expect(result).to be_falsey }
    end
  end

  context 'when payment' do
    let(:params) do
      {
        current_user: user,
        current_order: order,
        step: :payment
      }
    end

    context 'when success' do
      let(:order) { create(:order, :at_payment_step, user: user) }

      it { expect(result).to be_truthy }
    end

    context 'when failure' do
      let(:order) { create(:order, :at_shipping_step, user: user) }

      it { expect(result).to be_falsey }
    end
  end

  context 'when confirm' do
    let(:params) do
      {
        current_user: user,
        current_order: order,
        step: :confirm
      }
    end

    context 'when success' do
      let(:order) { create(:order, :at_confirm_step, user: user) }

      it { expect(result).to be_truthy }
    end

    context 'when failure' do
      let(:order) { create(:order, :at_payment_step, user: user) }

      it { expect(result).to be_falsey }
    end
  end

  context 'when complete' do
    let(:params) do
      {
        current_user: user,
        current_order: order,
        step: :complete
      }
    end

    context 'when success' do
      let(:order) { create(:order, :at_complete_step, user: user) }

      it { expect(result).to be_truthy }
    end

    context 'when failure' do
      let(:order) { create(:order, :at_confirm_step, user: user) }

      it { expect(result).to be_falsey }
    end
  end
end
