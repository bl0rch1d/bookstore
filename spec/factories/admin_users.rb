FactoryBot.define do
  factory :admin_user do
    email { 'kojima_genius@example.com' }
    password { 'KaminoAlive' }
    password_confirmation { 'KaminoAlive' }
  end
end
