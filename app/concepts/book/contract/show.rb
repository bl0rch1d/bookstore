module Book::Contract
  class Show < Reform::Form
    property :id, virtual: true

    validates :id, presence: true, numericality: {
      only_integer: true,
      greater_than_or_equal_to: ApplicationRecord::MIN_ID_VALUE
    }
  end
end
