RSpec.describe AuthorDecorator do
  subject(:author) { create(:author).decorate }

  it '#full_name' do
    expect(author.full_name).to eq("#{author.first_name} #{author.last_name}")
  end
end
