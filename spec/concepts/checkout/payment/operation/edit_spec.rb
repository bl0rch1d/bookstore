describe Checkout::Payment::Edit do
  let(:result) { described_class.call(params.merge(step: :payment)) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_payment_step, user: user) }

  let(:valid_credit_card_params) { ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id)) }

  describe 'Success' do
    let(:params) do
      {
        current_order: order,
        current_user: user
      }
    end

    it 'creates credit_card form' do
      expect(result['contract.default']).to be_a(Checkout::Payment::Contract::CreditCard)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      context 'when user policy fails' do
        let(:params) do
          {
            current_order: order,
            current_user: create(:user),
            order: {
              credit_card: valid_credit_card_params
            }
          }
        end

        it do
          expect(result['result.policy.user']).to be_failure
          expect(result).to be_failure
        end
      end
    end
  end
end
