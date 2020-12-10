require "rails_helper"
RSpec.describe User, type: :model do
  let!(:user){FactoryBot.create :user,
                               email: "a@gmail.com", activated: "true"}
  let(:user2){FactoryBot.create :user,
                               email: "aa@gmail.com"}
  describe ".by_email" do
    context "when valid param" do
      it "return record" do
        expect(User.by_email(user.email)).to eq [user]
      end
    end
    context "when nil param" do
      it "return all record" do
        expect(User.by_email(user.email)).to eq [user, user2]
      end
    end
  end

  describe ".activated" do
    context "update activated success" do
      it "return true" do
        expect(user.activated).to eq true
      end
    end
  end

  describe ".forget" do
    context "update foget remember_digest" do
      it "return true" do
        expect(user.forget).to eq true
      end
    end
  end
end
