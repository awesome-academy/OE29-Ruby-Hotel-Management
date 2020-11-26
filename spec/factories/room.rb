FactoryBot.define do
  factory :room do
    name {Faker::Name.name}
    des {Faker::Lorem.paragraph(sentence_count: 2)}
    price {100000}
    view { FactoryBot.create :view}
    type { FactoryBot.create :type}
  end
end
