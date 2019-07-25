RSpec.describe Coupon::Policy::ApplyGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  describe 'Success' do
    let(:params) { { order: create(:order) } }

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when order not present' do
      let(:params) { { order: nil } }

      it { expect(result).to be_falsey }
    end

    context 'when order not Order' do
      let(:params) { { order: create(:book) } }

      it { expect(result).to be_falsey }
    end
  end
end
