# class Review::Policy::CreateGuard
#   include Uber::Callable

#   def call(_ctx, params:, **)
#     params[:current_user]&.id == params.dig(:review, :user_id).to_i && Book.exists?(params.dig(:review, :book_id))
#   end
# end

describe Review::Policy::CreateGuard do
  let(:result) { described_class.new.call(nil, params: params) }

  let(:current_user) { create(:user) }

  describe 'Success' do
    let(:params) do
      {
        current_user: current_user,
        review: ActionController::Parameters.new(attributes_for(:review, user_id: current_user.id))
      }
    end

    it { expect(result).to be_truthy }
  end

  describe 'Failure' do
    context 'when user is not logged in' do
      let(:params) do
        {
          current_user: nil,
          review: ActionController::Parameters.new(attributes_for(:review, user_id: current_user.id))
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when current_user != user_id' do
      let(:params) do
        {
          current_user: current_user,
          review: ActionController::Parameters.new(attributes_for(:review, user_id: 323))
        }
      end

      it { expect(result).to be_falsey }
    end

    context 'when book not exist' do
      let(:params) do
        {
          current_user: current_user,
          review: ActionController::Parameters.new(attributes_for(:review, user_id: current_user.id, book: 323))
        }
      end

      it { expect(result).to be_falsey }
    end
  end
end
