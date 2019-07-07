class Review < ApplicationRecord
  include AASM

  TEXT_REGEX = %r{\A[\p{L}\d\s!#$%&'*+-/=?^_`{|}~]+\z}.freeze
  RATING_RANGE = (1..5).freeze
  TITLE_LENGTH = 50
  BODY_LENGTH = 500

  belongs_to :customer
  belongs_to :book

  validates :title, presence: true, length: { maximum: TITLE_LENGTH }
  validates :body, :rating, presence: true, length: { maximum: BODY_LENGTH }, format: { with: TEXT_REGEX }
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
