RSpec.describe Checkout::Complete do
  let(:result) { described_class.call(params) }

  let(:user) { create :user }

  let(:order) { create(:order, :full, user: user) }

  describe 'Success' do
    let(:params) do
      {
        'current_order' => order,
        'current_user' => user,
        'step' => :complete,
        'session' => { current_order_id: order.id }
      }
    end

    it do
      expect(result['model']).to be_a(Order)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when policy fails' do
      let(:params) do
        {
          'current_order' => order,
          'current_user' => create(:user),
          'step' => :complete
        }
      end

      it { expect(result).to be_failure }
    end
  end
end
