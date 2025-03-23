FactoryBot.define do
  factory :user do
    name { "Иван" }
    family_name { "Иванов" }
    city { "Moscow" }
    password { "password" }
    password_confirmation { "password" }
    role { "admin" }
  end
end
