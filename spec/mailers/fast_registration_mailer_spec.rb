describe FastRegistrationMailer, type: :mailer do
  let!(:user) { create :user }

  describe 'temporary_password  ' do
    let(:mail) { described_class.temporary_password(user, Array.new(8) { rand(1..9) }) }

    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('user.mailer.subject', user_email: user.email))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([I18n.t('store.email')])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(I18n.t('user.mailer.subject', user_email: user.email))
    end
  end
end
