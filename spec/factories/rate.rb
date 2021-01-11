FactoryBot.define do
  factory :rate do
    user {FactoryBot.create :user}
    room {FactoryBot.create :room}
    score {4}
  end
end
