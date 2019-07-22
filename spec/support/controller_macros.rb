module ControllerMacros
  def login_user
    before do
      user = create(:user)
      user.confirmed_at = Time.zone.now
      user.save
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end
