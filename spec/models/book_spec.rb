describe Book, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_many(:authors_books).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:authors_books) }

    it { is_expected.to have_many(:books_materials).dependent(:destroy) }
    it { is_expected.to have_many(:materials).through(:books_materials) }

    it { is_expected.to have_many(:reviews).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }

    it { is_expected.to have_many(:images_attachments).conditions(name: :images).inverse_of(:record) }
    it { is_expected.to have_many(:images_blobs).through(:images_attachments) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:depth) }
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:width) }

    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }

    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(ApplicationRecord::MIN_PRICE) }
    it { is_expected.to validate_numericality_of(:price).is_less_than_or_equal_to(ApplicationRecord::MAX_PRICE) }

    it { is_expected.to validate_numericality_of(:quantity).only_integer }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(Book::MIN_QUANTITY) }
    it { is_expected.to validate_numericality_of(:quantity).is_less_than_or_equal_to(Book::MAX_QUANTITY) }

    it { is_expected.to accept_nested_attributes_for(:images_attachments) }
  end
end
