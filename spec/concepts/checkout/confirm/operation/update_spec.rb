describe Checkout::Confirm::Update do
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

    it do
      expect(result).to be_success

      expect(order.number).to be_present
      expect(order.completed_at).to be_present
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
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
    end
  end
end
