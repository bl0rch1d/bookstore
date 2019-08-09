describe Category, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }
  end
end
