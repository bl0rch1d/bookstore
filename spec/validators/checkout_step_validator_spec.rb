describe CheckoutStepValidator do
  let(:result) { described_class.new(order, step).step_allowed? }

  let(:user) { create(:user) }

  context 'when address' do
    let(:step) { :address }

    context 'when success' do
      let(:order) { create(:order, :at_address_step, user: user) }

      it { expect(result).to be_truthy }
    end
  end

  context 'when shipping' do
    let(:step) { :shipping }

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
    let(:step) { :payment }

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
    let(:step) { :confirm }

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
    let(:step) { :complete }

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
