module Book::Contract
  class Index < Reform::Form
    SORTINGS = %w[newest popular high_price low_price title_ascending title_descending].freeze

    MIN_PAGE_VALUE = 1
    MIN_CATEGORY_ID_VALUE = 0

    property :page, virtual: true, default: MIN_PAGE_VALUE
    property :sort_by, virtual: true

    validates :page, numericality: { only_integer: true, greater_than_or_equal_to: MIN_PAGE_VALUE }
    validates :sort_by, inclusion: { in: SORTINGS }, allow_nil: true
  end
end
