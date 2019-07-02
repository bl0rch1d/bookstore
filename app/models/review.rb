class Review < ApplicationRecord
  include AASM

  TEXT_REGEX = %r{\A[\p{L}\d\s!#$%&'*+-/=?^_`{|}~]+\z}.freeze
  RATING_RANGE = (1..5).freeze

  belongs_to :customer
  belongs_to :book

  validates :body, :rating, presence: true, length: { maximum: 500 }, format: { with: TEXT_REGEX }
  validates :rating, inclusion: { in: RATING_RANGE }

  scope :processed, -> { approved.or(rejected) }

  aasm column: :state do
    state :unprocessed, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :unprocessed, to: :approved
    end

    event :reject do
      transitions from: :unprocessed, to: :rejected
    end
  end
end
