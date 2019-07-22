RSpec.describe Book::Index do
  subject(:result) { described_class.call(params) }

  let(:params) { { sort_by: 'title_ascending', page: page, items: items } }
  let(:page) { 2 }
  let(:items) { 12 }

  describe 'Success' do
    before do
      create_list(:book, 50)
    end

    it 'returns paginated list of books' do
      expect(result['result.contract.default']).to be_success

      expect(result['model']).to be_a(ActiveRecord::Relation)
      expect(result['model'].sample).to be_a(Book)
      expect(result['model'].size).to be(12)
      expect(result['pagy']).to be_instance_of(Pagy)

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when page is not valid' do
      let(:page) { 'wrong' }
      let(:errors) do
        {
          page: ['is not a number']
        }
      end

      it 'has validation errors' do
        expect(result['contract.default'].errors.messages).to match errors
        expect(result).to be_failure
      end
    end

    context 'when page is out of limits' do
      let(:page) { 9999 }
      let(:errors) do
        {
          page: ['is out of limits']
        }
      end

      it 'has validation errors' do
        expect(result['contract.default'].errors.messages).to match errors
        expect(result).to be_failure
      end
    end
  end
end
