class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  # === TODO: Decorator ===
  def to_s
    "#{first_name} #{last_name}"
  end
end
