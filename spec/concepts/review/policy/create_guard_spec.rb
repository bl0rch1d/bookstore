RSpec.describe Review::Policy::CreateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:user) { create(:user) }

  describe 'Success' do
    let(:params) do
      {
        current_user: user,
        book_id: create(:book).id,
        user_id: user.id
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when user is not present' do
      let(:params) do
        {
          current_user: user,
          book_id: create(:book)
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when current_user != form user_id' do
      let(:params) do
        {
          current_user: user,
          book_id: create(:book).id,
          user_id: create(:user).id
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when book not exist' do
      let(:params) do
        {
          current_user: user,
          book_id: 3000,
          user_id: create(:user).id
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
