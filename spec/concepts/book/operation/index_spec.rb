RSpec.describe Book::Index do
  subject(:result) { described_class.call(params) }

  let(:params) { { category_id: category_id, sort_by: sort_by, page: page, items: items } }
  let(:page) { 2 }
  let(:items) { 12 }

  before do
    create_list(:book, 24)
  end

  describe 'Success' do
    let(:sort_by) { I18n.t('sortings.system.title_ascending') }
    let(:category_id) { '0' }

    it 'returns paginated list of books' do
      expect(result['model']).to be_a(ActiveRecord::Relation)
      expect(result['model'].sample).to be_a(Book)
      expect(result['model'].size).to be(12)
      expect(result['pagy']).to be_instance_of(Pagy)

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when page is out of limits' do
      let(:page) { 9999 }
      let(:sort_by) { I18n.t('sortings.system.title_ascending') }
      let(:category_id) { '0' }
      let(:errors) { [I18n.t('errors.format', attribute: :Page, message: I18n.t('validation_errors.out_of_limits'))] }

      it 'has validation errors' do
        expect(result['contract.default'].errors.full_messages).to match errors
        expect(result).to be_failure
      end
    end

    context 'when category is invalid' do
      let(:page) { 1 }
      let(:sort_by) { I18n.t('sortings.system.title_ascending') }
      let(:category_id) { 'dsadas' }

      it do
        expect(result).to be_failure
      end
    end

    context 'when sorting is invalid' do
      let(:page) { 1 }
      let(:sort_by) { 'dsadas' }
      let(:category_id) { '0' }

      it do
        expect(result).to be_failure
      end
    end
  end
end
