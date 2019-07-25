RSpec.describe Book::Query::Index do
  let(:result) { described_class.call(params) }

  before do
    create_list(:book, 30)
  end

  context 'when default' do
    let(:params) { { sort_by: 'sdsad' } }

    it 'title ascending' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.ascending_title)
    end
  end

  context 'when Newest first' do
    let(:params) { { sort_by: 'newest' } }

    it 'newest' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.most_recent)
    end
  end

  context 'when Popular first' do
    let(:params) { { sort_by: 'popular' } }

    it 'popular' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.most_popular)
    end
  end

  context 'when Price: High to low' do
    let(:params) { { sort_by: 'high_price' } }

    it 'descending_price' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.descending_price)
    end
  end

  context 'when Price: Low to high' do
    let(:params) { { sort_by: 'low_price' } }

    it 'ascending_price' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.ascending_price)
    end
  end

  context 'when Title: A - Z' do
    let(:params) { { sort_by: 'title_ascending' } }

    it 'ascending_title' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.ascending_title)
    end
  end

  context 'when Title: Z - A' do
    let(:params) { { sort_by: 'title_descending' } }

    it 'descending_title' do
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.sample).to be_a(Book)
      expect(result).to eq(Book.all.descending_title)
    end
  end
end
