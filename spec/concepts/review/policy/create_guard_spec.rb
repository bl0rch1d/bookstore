RSpec.describe Review::Policy::CreateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  describe 'Success' do
    let(:params) do
      {
        current_user: create(:user),
        book_id: create(:book).id
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when user is not present' do
      let(:params) do
        {
          book_id: create(:book)
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when book not exist' do
      let(:params) do
        {
          book_id: 1000
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
