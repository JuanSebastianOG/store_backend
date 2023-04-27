FactoryBot.define do
  factory :store do
    name { Faker::Name.name }
    url { Faker::Internet.url }
  end
end
