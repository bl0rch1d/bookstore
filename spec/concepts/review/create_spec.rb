RSpec.describe Review::Create do
  let(:result) { described_class.call(review_params, 'current_user' => current_user) }

  let(:current_user) { create :user }
  let(:review_params) { attributes_for(:review) }
  let(:invalid_review_params) { attributes_for(:book) }

  # let(:params) { { sort_by: 'title_ascending', page: page, items: items } }
  # let(:current_user) { 2 }
  # let(:items) { 12 }
  
  describe 'Success' do
    it 'Creates a review' do
      expect(result['model']).to be_a(Review)

      expect(result['result.contract.default']).to be_success

      # expect(result['model']).to be_a(ActiveRecord::Relation)
      # expect(result['model'].sample).to be_a(Book)
      # expect(result['model'].size).to be(12)
      # expect(result['pagy']).to be_instance_of(Pagy)

      expect(Review.last.body).to eq(review_params[:body])

      expect(result).to be_success
    end
  end

  # describe 'Failure' do
  #   context 'when page is not valid' do
  #     let(:page) { 'wrong' }
  #     let(:errors) do
  #       {
  #         page: ['is not a number']
  #       }
  #     end

  #     it 'has validation errors' do
  #       expect(result['contract.default'].errors.messages).to match errors
  #       expect(result).to be_failure
  #     end
  #   end

  #   context 'when page is out of limits' do
  #     let(:page) { 9999 }
  #     let(:errors) do
  #       {
  #         page: ['is out of limits']
  #       }
  #     end

  #     it 'has validation errors' do
  #       expect(result['contract.default'].errors.messages).to match errors
  #       expect(result).to be_failure
  #     end
  #   end
  # end
end
