FactoryBot.define do
  factory :bill do
    status {"waiting"}
    user {FactoryBot.create :user}
    price {100000}
  end
end
