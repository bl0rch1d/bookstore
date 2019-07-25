RSpec.describe Order::Query::Index do
  let(:result) { described_class.call(user, params) }

  context 'when default' do
    let(:user) { create :user, :with_orders }
    let(:params) { {} }

    it 'in_progress' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end

  context 'when in_progress' do
    let(:user) { create :user, :with_orders }
    let(:params) { { sort_by: 'in_progress' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end

  context 'when in_delivery' do
    let(:user) { create :user, :with_orders }
    let(:params) { { sort_by: 'in_delivery' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_delivery'))
    end
  end

  context 'when delivered' do
    let(:user) { create :user, :with_orders }
    let(:params) { { sort_by: 'delivered' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.delivered'))
    end
  end

  context 'when canceled' do
    let(:user) { create :user, :with_orders }
    let(:params) { { sort_by: 'canceled' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.canceled'))
    end
  end

  context 'when something else' do
    let(:user) { create :user, :with_orders }
    let(:params) { { sort_by: 'dsadasdasd' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end
end
