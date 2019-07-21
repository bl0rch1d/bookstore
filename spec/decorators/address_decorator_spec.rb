require 'rails_helper'

RSpec.describe AddressDecorator do
  subject(:address) { create(:shipping_address, :for_order).decorate }

  it '#full_name' do
    expect(address.full_name).to eq("#{address.first_name} #{address.last_name}")
  end

  it '#city_zip' do
    expect(address.city_zip).to eq("#{address.city} #{address.zip}")
  end
end
