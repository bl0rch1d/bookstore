module Review::Contract
  class Create < Reform::Form
    TITLE_LENGTH = 50
    TEXT_REGEX = %r{\A[\p{L}\d\s!#$%&'*+-/=?^_`{|}~]+\z}.freeze
    RATING_RANGE = (1..5).freeze
    BODY_LENGTH = 500

    property :title
    property :body
    property :rating
    property :user_id
    property :book_id

    validates :title, presence: true, length: { maximum: TITLE_LENGTH }
    validates :body, :rating, presence: true, length: { maximum: BODY_LENGTH }, format: { with: TEXT_REGEX }
    validates :rating, numericality: { only_integer: true }, inclusion: { in: RATING_RANGE }

    def rating=(value)
      super value.to_i
    end
  end
end
