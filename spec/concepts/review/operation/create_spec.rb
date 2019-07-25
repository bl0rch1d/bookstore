RSpec.describe Review::Create do
  let(:result) { described_class.call(params) }

  describe 'Success' do
    let(:current_user) { create :user }
    let(:review_params) { attributes_for(:review) }

    let(:params) { review_params.merge(current_user: current_user) }

    it 'Creates a review' do
      expect(result['model']).to be_a(Review)
      expect(result['result.contract.default']).to be_success
      expect(Review.last.body).to eq(review_params[:body])

      expect(result).to be_success
    end
  end

  describe 'Failure' do
    let(:current_user) { create :user }
    let(:review_params) { attributes_for(:book) }

    let(:params) { review_params.merge(current_user: current_user) }

    context 'when params invalid' do
      it { expect(result).to be_failure }
    end

    context 'when failed policy condition' do
      let(:current_user) { nil }
      let(:review_params) { attributes_for(:review) }

      let(:params) { review_params.merge(current_user: current_user) }

      it { expect(result).to be_failure }
    end
  end
end
