if Rails.env.development?
  AdminUser.create!(
    email: 'kojima_genius@example.com',
    password: 'KaminoAlive',
    password_confirmation: 'KaminoAlive'
  )
end
