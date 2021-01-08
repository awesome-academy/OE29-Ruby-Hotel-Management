FactoryBot.define do
  factory :service do
    name {Faker::Name.name}
    des {Faker::Lorem.paragraph(sentence_count: 3)}
    unity {FactoryBot.create :unity}
    price {1000000}
  end
end
