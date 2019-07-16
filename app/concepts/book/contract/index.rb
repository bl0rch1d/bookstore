module Book::Contract
  class Index < Reform::Form
    property :page, virtual: true, default: 1

    validates :page, numericality: { only_integer: true, greater_or_equal_to: 1 }

    def page=(value)
      super.to_i
    end
  end
end
