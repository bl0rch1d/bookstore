module Book::Contract
  class Index < Reform::Form
    MIN_PAGE_VALUE = 1

    property :page, virtual: true, default: MIN_PAGE_VALUE
    property :sort_by, virtual: true

    validates :page, numericality: { only_integer: true, greater_than_or_equal_to: MIN_PAGE_VALUE }
    validates :sort_by, inclusion: { in: Query::Index::SORTINGS }, allow_nil: true
  end
end
