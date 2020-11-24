FactoryBot.define do
  factory :booking do
    room { FactoryBot.create :room}
    bill {FactoryBot.create :bill}
  end
end
