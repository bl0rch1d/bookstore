class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MAX_TITLE_LENGTH = 50

  MAX_PRICE = 100_000
  MIN_PRICE = 0

  MIN_ID_VALUE = 1
end
