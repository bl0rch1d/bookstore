RSpec.describe Review, type: :model do
  subject(:review) { create :review }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:book) }

  context 'when aasm state' do
    it 'unprocessed -> approved' do
      expect(review).to transition_from(:unprocessed).to(:approved).on_event(:approve)
    end

    it 'unprocessed -> rejected' do
      expect(review).to transition_from(:unprocessed).to(:rejected).on_event(:reject)
    end
  end
end
