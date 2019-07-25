module Order::Contract
  class Index < Reform::Form
    FILTERS = %w[in_progress in_delivery delivered canceled].freeze

    property :sort_by, virtual: true

    validates :sort_by, presence: true, inclusion: { in: FILTERS }
  end
end
