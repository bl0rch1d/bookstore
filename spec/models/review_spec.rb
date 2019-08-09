describe Review, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book) }
  end

  context 'states' do
    subject(:review) { create :review }

    it 'unprocessed -> approved' do
      expect(review).to transition_from(:unprocessed).to(:approved).on_event(:approve)
    end

    it 'unprocessed -> rejected' do
      expect(review).to transition_from(:unprocessed).to(:rejected).on_event(:reject)
    end
  end
end
