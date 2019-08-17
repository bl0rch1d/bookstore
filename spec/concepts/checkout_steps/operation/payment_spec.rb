describe CheckoutStep::Payment do
  let(:present_result) { described_class::Present.call(params.merge(step: :payment)) }
  let(:result) { described_class.call(params.merge(step: :payment)) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_payment_step, user: user) }

  describe 'Success' do
    context 'when Payment::Present' do
      let(:params) do
        {
          current_order: order,
          current_user: user
        }
      end

      it 'creates credit_card form' do
        expect(present_result['contract.default']).to be_a(CheckoutStep::Contract::CreditCard)
        expect(present_result).to be_success
      end
    end

    context 'when Payment' do
      let(:params) do
        {
          current_order: order,
          current_user: user,
          credit_card: ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id))
        }
      end

      it do
        expect(result['model']).to be_a(CreditCard)

        order.reload

        expect(order.credit_card).to eq(result['model'])
        expect(result).to be_success
      end
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      context 'when checkout policy fails' do
        let(:order) { create(:order, user: user) }

        let(:params) do
          {
            current_order: order,
            current_user: user,
            credit_card: ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id))
          }
        end

        it do
          expect(result['result.policy.checkout']).to be_failure
          expect(result).to be_failure
        end
      end

      context 'when user policy fails' do
        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            credit_card: ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id))
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end

      context 'when step policy fails' do
        let(:params) do
          {
            current_order: create(:order, :at_shipping_step, user: user),
            current_user: user,
            credit_card: ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id))
          }
        end

        it do
          expect(result['result.policy.step']).to be_failure
          expect(result).to be_failure
        end
      end
    end

    context 'when validation fails' do
      let(:params) do
        {
          current_order: order,
          current_user: user,
          credit_card: ActionController::Parameters.new(attributes_for(:user))
        }
      end

      it do
        expect(result['contract.default'].errors.messages).to be_any
        expect(result).to be_failure
      end
    end
  end
end
