require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { is_expected.to belong_to(:addressable) }
end
