User.where(
  id: '0'
).first_or_create!(
  role: :admin,
  name: :admin,
  password: 'admin',
  password_confirmation: 'admin'
)

puts 'Done.'
