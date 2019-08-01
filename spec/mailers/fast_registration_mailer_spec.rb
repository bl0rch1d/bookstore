RSpec.describe FastRegistrationMailer, type: :mailer do
  let!(:user) { create :user }

  describe 'temporary_password  ' do
    let(:mail) { described_class.temporary_password(user, Array.new(8) { rand(1..9) }) }

    it 'renders the headers' do
      expect(mail.subject).to eq("Temporary password for #{user.email}.")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['bookstore@bookstore_diz.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Temporary password for #{user.email}.")
    end
  end
end
