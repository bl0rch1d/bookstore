module Order::Contract
  class Show < Reform::Form
    property :id, virtual: true

    validates :id, presence: true, numericality: { only_integer: true }
  end
end
