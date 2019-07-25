RSpec.describe Coupon::Apply do
  let(:result) { described_class.call(code: code, order: order) }

  let(:coupon) { create :coupon }

  describe 'Success' do
    let(:code) { coupon.code }
    let(:order) { create :order }

    it 'applies coupon' do
      expect(result['result.policy.default']).to be_success
      expect(result).to be_success
      expect(order.coupon.id).to eq(coupon.id)
    end
  end

  describe 'Failure' do
    context 'when coupon not exists' do
      let(:code) { 'dsadad' }
      let(:order) { create :order }

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end

    context 'when coupon has expired' do
      let(:code) { create(:coupon, :expired).code }
      let(:order) { create :order }

      it do
        expect(result['coupon.relevant']).to be_falsey
        expect(result).to be_failure
      end
    end

    context 'when policy failed' do
      let(:code) { create(:coupon).code }
      let(:order) { {} }

      it do
        expect(result['result.policy.default']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
