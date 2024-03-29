describe Book::Show do
  subject(:result) { described_class.call(params) }

  let(:params) { { id: 4 } }

  describe 'Success' do
    before do
      create_list(:book, 10)
    end

    it 'returns book' do
      expect(result['model']).to be_a(Book)

      expect(result).to be_success
    end
  end
end
