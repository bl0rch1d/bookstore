RSpec.describe Checkout::Payment do
  let(:user) { create :user }

  describe 'Success' do
    context 'when Payment::Present' do
      let(:result) { described_class::Present.call(params) }

      let(:params) do
        {
          'current_order' => create(:order, :at_payment_step, user: user),
          'current_user' => user,
          'step' => :payment
        }
      end

      it 'creates credit_card form' do
        expect(result['contract.default']).to be_a(Checkout::Contract::CreditCard)
        expect(result).to be_success
      end
    end

    context 'when Payment' do
      let(:result) { described_class.call(params) }

      let(:order) { create(:order, :at_payment_step, user: user) }

      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :payment,
          'credit_card' => ActionController::Parameters.new(attributes_for(:credit_card))
        }
      end

      it do
        expect(result['model']).to be_a(CreditCard)

        expect(order.credit_card).to eq(result['model'])

        expect(result).to be_success
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

      it do
        expect(result['model']).to be_nil

        expect(result).to be_failure
      end
    end

    context 'when validation fails' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :payment,
          'credit_card' => ActionController::Parameters.new(CreditCard.new.attributes)
        }
      end

      it do
        expect(result['contract.default'].errors.messages).to be_any

        expect(result).to be_failure
      end
    end

    # === HELP THERE ===
    context 'when persist fails' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => user,
          'step' => :payment,
          'credit_card' => ActionController::Parameters.new(attributes_for(:book))
        }
      end

      it { expect(result).to be_failure }
    end
  end
end
