RSpec.describe Order::Contract::Index do
  let(:contract) { described_class.new(sort_by: nil) }

  describe 'Success' do
    let(:params) { { sort_by: I18n.t('order.filter.in_progress') } }

    it { expect(contract.validate(params)).to be_truthy }
  end

  describe 'Failure' do
    context 'when invalid params' do
      let(:params) { { sort_by: 23 } }
      let(:error) { [I18n.t('errors.format', attribute: :"Sort by", message: I18n.t('errors.messages.inclusion'))] }

      it do
        expect(contract.validate(params)).to be_falsey
        expect(contract.errors.full_messages).to eq(error)
      end
    end
  end
end
