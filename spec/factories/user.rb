FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.unique.email}
    age {10}
    password {"1234567"}
    role {"client"}
  end
end
