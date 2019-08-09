describe Material, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:books_materials).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:books_materials) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }
  end
end
