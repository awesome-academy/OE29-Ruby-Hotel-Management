require "rails_helper"
RSpec.describe Room, type: :model do
  let!(:room){FactoryBot.create :room}
  let(:user){FactoryBot.create :user}
  let!(:room1){FactoryBot.create :room}
  let!(:room2){FactoryBot.create :room}
  let!(:rate){FactoryBot.create :rate,user: user, room: room, score: 4}
  let!(:rate1){FactoryBot.create :rate,user: user, room: room, score: 2}
  let!(:booking){FactoryBot.create :booking, checkin: "14-09-2020", checkout: "16-09-2020", room: room}
  let!(:booking2){FactoryBot.create :booking,checkin: "14-09-2020", checkout: "16-09-2020", room: room1}

  describe  ".valid_room" do
    context "when valid param" do
      it "should return record" do
        expect(Room.valid_room("14-09-2020".to_date,"16-09-2020".to_date).pluck(:id)).to eq [room2.id]
      end
    end
  end

  describe  ".check_score" do
    it "should return rate" do
      expect(room.check_score).to eq 3
    end
  end

  describe  ".average_score" do
    it "should return rate" do
      expect(room.average_score).to eq 3.0
    end
  end
end
