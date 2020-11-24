FactoryBot.define do
  factory :room do
    name {Faker::Name.name}
    des {"This is room"}
    price {100000}
    view { FactoryBot.create :view}
    type { FactoryBot.create :type}
  end
end
