require "rails_helper"
RSpec.describe Booking, type: :model do
  let!(:bill) {FactoryBot.create :bill}
  let!(:booking){FactoryBot.create :booking, bill: bill}
  let!(:booking2){FactoryBot.create :booking, bill: bill}
  let!(:booking3){FactoryBot.create :booking}
  let(:booking4){FactoryBot.build :booking, price: " "}

  describe "Validations" do
    it "valid all field" do
      expect(booking3.valid?).to eq true
    end

    it "invalid any field" do
      expect(booking4.valid?).to eq false
    end
  end

  describe "Associations" do
    it "has many booking_services" do
      is_expected.to have_many(:booking_services).dependent :destroy

    end

    it "be long to bill" do
      is_expected.to belong_to :bill
    end

    it "be long to room" do
      is_expected.to belong_to :room
    end
  end

  describe "Nested attributes" do
    it "booking services" do
      is_expected.to accept_nested_attributes_for(:booking_services).allow_destroy true
    end
  end

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
