RSpec.describe AuthorsBook, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:book) }
  end
end
