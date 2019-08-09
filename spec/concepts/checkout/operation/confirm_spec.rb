describe Checkout::Confirm do
  let(:user) { create :user }

  describe 'Success' do
    context 'when Confirm::Present' do
      let(:result) { described_class::Present.call(params) }

      let(:params) do
        {
          'current_order' => create(:order, :full, user: user),
          'current_user' => user,
          'step' => :confirm
        }
      end

      it 'passes policy condition' do
        expect(result).to be_success
      end
    end

    context 'when Confirm' do
      let(:result) { described_class.call(params) }

      let(:order) { create(:order, :full, user: user) }

      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :confirm
        }
      end

      it do
        expect(result).to be_success

        expect(order.number).to be_present
        expect(order.completed_at).to be_present
      end
    end
  end

  describe 'Failure' do
    let(:result) { described_class.call(params) }

    let(:order) { create(:order, :at_payment_step, user: user) }

    context 'when policy fails' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => create(:user),
          'step' => :payment,
          'credit_card' => ActionController::Parameters.new(attributes_for(:credit_card))
        }
      end

      it { expect(result).to be_failure }
    end
  end
end
