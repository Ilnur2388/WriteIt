FactoryBot.define do
  factory :post do
    title { "Тестовый пост" }
    body { "Содержимое тестового поста" }
    state { "draft" }
    city { "Moscow" }
    association :user
  end
end
