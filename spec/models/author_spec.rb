RSpec.describe Author, type: :model do
  context 'relations' do
    it { is_expected.to have_many(:authors_books).dependent(:destroy) }
    it { is_expected.to have_many(:books).through(:authors_books) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it { is_expected.to validate_length_of(:first_name).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }

    it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name) }
  end
end
