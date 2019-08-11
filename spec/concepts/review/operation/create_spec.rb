describe Review::Create do
  let(:result) { described_class.call(params) }

  let(:current_user) { create :user }

  describe 'Success' do
    let(:params) do
      {
        review: ActionController::Parameters.new(attributes_for(:review, user_id: current_user.id)),
        current_user: current_user
      }
    end

    it 'Creates a review' do
      expect(result['model']).to be_a(Review)
      expect(Review.last.body).to eq(params[:review][:body])
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    context 'when params invalid' do
      let(:params) do
        {
          review: ActionController::Parameters.new(
            attributes_for(:review, user_id: current_user.id, body: '', title: '')
          ),
          current_user: current_user
        }
      end

      it do
        expect(result['contract.default'].errors.full_messages.size).to eq(3)
        expect(result).to be_failure
      end
    end

    context 'when failed policy condition' do
      let(:params) do
        {
          review: ActionController::Parameters.new(attributes_for(:review, user_id: 213)),
          current_user: current_user
        }
      end

      it do
        expect(result['result.policy.user']).to be_failure
        expect(result).to be_failure
      end
    end
  end
end
