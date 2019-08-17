describe CheckoutStep::Confirm do
  let(:present_result) { described_class::Present.call(params.merge(step: :confirm)) }
  let(:result) { described_class.call(params.merge(step: :confirm)) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_confirm_step, user: user) }

  describe 'Success' do
    let(:params) do
      {
        current_order: order,
        current_user: user
      }
    end

    context 'when Confirm::Present' do
      it 'passes policy condition' do
        expect(present_result).to be_success
      end
    end

    context 'when Confirm' do
      it do
        expect(result).to be_success

        expect(order.number).to be_present
        expect(order.completed_at).to be_present
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
            current_user: user
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
            current_user: create(:user)
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
            current_order: create(:order, :at_payment_step, user: user),
            current_user: user
          }
        end

        it do
          expect(result['result.policy.step']).to be_failure
          expect(result).to be_failure
        end
      end
    end
  end
end
