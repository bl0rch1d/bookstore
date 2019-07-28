require 'rails_helper'
require 'devise'

def register_user
  visit root_path

  click_link('My account')
  click_link('Sign up')

  within '#new_user' do
    fill_in 'user[email]',                  with: FFaker::Internet.email
    fill_in 'user[password]',               with: 'Password123'
    fill_in 'user[password_confirmation]',  with: 'Password123'

    click_button('Sign up')
  end

  User.first.confirm
end

def sign_in_user
  visit root_path

  click_link('My account')
  click_link('Log in')

  within '#new_session' do
    fill_in 'email',    with: User.first.email
    fill_in 'password', with: 'Password123'

    click_button('Log in')
  end
end
