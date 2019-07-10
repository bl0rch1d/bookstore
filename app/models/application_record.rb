class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  MAX_TITLE_LENGTH = 50

  MAX_PRICE = 100_000
  MIN_PRICE = 1
end
