FactoryBot.define do
  factory :post do
    title { "MyString" }
    subtitle { "MyText" }
    body { "MyText" }
    published { false }
    position { 1 }
    user { nil }
  end
end
