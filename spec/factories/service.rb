FactoryBot.define do
  factory :service do
    name {Faker::Name.name}
    des {Faker::Lorem.paragraph(sentence_count: 3)}
    price {1000000}
  end
end
