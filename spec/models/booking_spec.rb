require "rails_helper"
RSpec.describe Booking, type: :model do
  let!(:bill) {FactoryBot.create :bill}
  let!(:booking){FactoryBot.create :booking, bill: bill}
  let!(:booking2){FactoryBot.create :booking, bill: bill}
  let!(:booking3){FactoryBot.create :booking}

  describe  ".by_bill_id" do
    context "when valid param" do
      it "should return record" do
        expect(Booking.by_bill_id booking.bill_id).to include booking, booking2
      end
    end
    context "when nil param" do
      it "return all record" do
        expect(Booking.by_bill_id(nil).size).to eq 3
      end
    end
  end
end
