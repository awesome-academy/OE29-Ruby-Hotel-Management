FactoryBot.define do
  factory :comment do
    booking {FactoryBot.create :booking}
    service {FactoryBot.create :service}
  end
end
