FactoryBot.define do
  factory :booking_service do
    amount {1}
    booking { FactoryBot.create :booking}
    service { FactoryBot.create :service}
  end
end
