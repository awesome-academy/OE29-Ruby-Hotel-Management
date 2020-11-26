FactoryBot.define do
  factory :booking do
    status{0}
    price {100000}
    checkin{"2020-10-22 16:48:04.122554"}
    checkout{"2020-10-28 16:48:04.122554"}
    room { FactoryBot.create :room}
    bill {FactoryBot.create :bill}
  end
end
