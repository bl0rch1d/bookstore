describe Order::Query::Index do
  let(:result) { described_class.new.call(user, params) }

  let(:user) { create :user, :with_orders }

  context 'when default' do
    let(:params) { {} }

    it 'in_progress' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end

  context 'when all' do
    let(:params) { { sort_by: I18n.t('order.all') } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
    end
  end

  context 'when in_progress' do
    let(:params) { { sort_by: I18n.t('order.filter.in_progress') } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end

  context 'when in_delivery' do
    let(:params) { { sort_by: I18n.t('order.filter.in_delivery') } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_delivery'))
    end
  end

  context 'when delivered' do
    let(:params) { { sort_by: I18n.t('order.filter.delivered') } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.delivered'))
    end
  end

  context 'when canceled' do
    let(:params) { { sort_by: I18n.t('order.filter.canceled') } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.canceled'))
    end
  end

  context 'when something else' do
    let(:params) { { sort_by: 'dsadasdasd' } }

    it do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Order)
      expect(result.sample.state).to eq(I18n.t('order.filter.in_progress'))
    end
  end
end
