module OmniAuthTestHelper
  def valid_facebook_login_setup(email: FFaker::Internet.email)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: 'facebook', uid: '123545',
                                                                  info: { email: email })
  end

  def invalid_facebook_login_setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(provider: nil, uid: nil, info: { email: nil })
  end

  def without_credentials_facebook_login_setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
end
