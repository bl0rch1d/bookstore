class Review < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :book

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
