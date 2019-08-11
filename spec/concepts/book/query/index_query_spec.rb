describe Book::Query::Index do
  let(:result) { described_class.new.call(params) }

  before do
    create_list(:book, 30)
  end

  context 'when default' do
    let(:params) { { sort_by: 'sdsad' } }

    it 'title ascending' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.ascending_title)
    end
  end

  context 'when Newest first' do
    let(:params) { { sort_by: I18n.t('sortings.system.newest') } }

    it 'newest' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.most_recent)
    end
  end

  context 'when Popular first' do
    let(:params) { { sort_by: I18n.t('sortings.system.popular') } }

    it 'popular' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.left_outer_joins(:order_items).group(:id).order('count(order_items.id) desc'))
    end
  end

  context 'when Price: High to low' do
    let(:params) { { sort_by: I18n.t('sortings.system.high_price') } }

    it 'descending_price' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.descending_price)
    end
  end

  context 'when Price: Low to high' do
    let(:params) { { sort_by: I18n.t('sortings.system.low_price') } }

    it 'ascending_price' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.ascending_price)
    end
  end

  context 'when Title: A - Z' do
    let(:params) { { sort_by: I18n.t('sortings.system.title_ascending') } }

    it 'ascending_title' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.ascending_title)
    end
  end

  context 'when Title: Z - A' do
    let(:params) { { sort_by: I18n.t('sortings.system.title_descending') } }

    it 'descending_title' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.descending_title)
    end
  end
end
