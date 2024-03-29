describe Checkout::Complete do
  let(:result) { described_class.call(params.merge(step: :complete, session: { current_order_id: order.id })) }

  let(:user) { create :user }

  let(:order) { create(:order, :at_complete_step, user: user) }

  describe 'Success' do
    let(:params) do
      {
        current_order: order,
        current_user: user
      }
    end

    it do
      expect(result['model']).to be_a(Order)
      expect(result).to be_success
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
