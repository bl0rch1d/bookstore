describe Coupon::Apply do
  let(:result) { described_class.call(code: code, order: order) }

  let(:coupon) { create :coupon }

  let(:order) { create :order }

  describe 'Success' do
    let(:code) { coupon.code }

    it 'applies coupon' do
      expect(result['result.policy.default']).to be_success
      expect(result).to be_success
      expect(order.coupon.id).to eq(coupon.id)
    end
  end

  describe 'Failure' do
    context 'when coupon not exists' do
      let(:code) { 'dsadad' }

      it do
        expect(result['model']).to be_nil
        expect(result).to be_failure
      end
    end

    context 'when coupon already used by another order' do
      let(:code) { create(:coupon, used: true).code }

      it do
        # binding.pry
        expect(result['coupon.used']).to be_falsey
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
