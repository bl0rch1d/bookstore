describe Checkout::Payment::Update do
  let(:result) { described_class.call(params.merge(step: :payment)) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_payment_step, user: user) }

  let(:valid_credit_card_params) { ActionController::Parameters.new(attributes_for(:credit_card, order_id: order.id)) }

  describe 'Success' do
    let(:params) do
      {
        current_order: order,
        current_user: user,
        order: {
          credit_card: valid_credit_card_params
        }
      }
    end

    it do
      expect(result['model']).to be_a(CreditCard)

      order.reload

      expect(order.credit_card).to eq(result['model'])
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

    context 'when validation fails' do
      let(:params) do
        {
          current_order: order,
          current_user: user,
          order: {
            credit_card: ActionController::Parameters.new(attributes_for(:user))
          }
        }
      end

      it do
        expect(result['contract.default'].errors.messages).to be_any
        expect(result).to be_failure
      end
    end
  end
end
