email = 'test@metastudio.ru'
params = { email: email, password: 'password', password_confirmation: 'password',
          confirmed_at: Time.current, confirmation_token: nil }
User.create!(params) unless User.exists?(email: email)
