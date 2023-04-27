FactoryBot.define do
  factory :product do
    store_id { Faker::Number.between(from: 0, to: 1000) }
    name { Faker::Name.name }
    sku { Faker::Number.between(from: 0, to: 1000) }
    inventory_quantity { Faker::Number.between(from: 0, to: 1000) }
    inventory_updated_time { Faker::Time.between(from: 1.year.ago, to: Date.today) }
  end
end
