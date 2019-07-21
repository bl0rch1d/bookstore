require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to have_many(:books).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(ApplicationRecord::MAX_TITLE_LENGTH) }
end
