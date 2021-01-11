require 'rails_helper'
RSpec.describe BillsController, type: :controller do
  let(:room) {FactoryBot.create :room}
  let(:room2) {FactoryBot.create :room}
  let(:user) {FactoryBot.create :user}
  let(:bill) {FactoryBot.create :bill}
  let(:bill2) {FactoryBot.create :bill, user: user}
  let!(:booking){FactoryBot.create(:booking, bill: bill2)}
  let!(:booking2){FactoryBot.create(:booking, bill: bill2)}

  before {log_in user}

  describe "GET #index" do
    before {get :index, params: {data: [room.id, room2.id]}, format: :js }

    it "should render edit template" do
      expect(response).to render_template :index
    end

    it "should assigns @list_room" do
      expect(assigns(:list_room).pluck(:id)).to eq [room.id, room2.id]
    end
  end

  describe "GET #show" do
    context "when valid param" do
      before do
        get :show, params: {id: bill2.id, page: 1}
      end

      it "should render show template" do
        expect(response).to render_template :show
      end

      it "should assigns @bookings" do
        expect(assigns(:bookings).pluck(:id)).to eq [booking.id, booking2.id]
      end
    end

    context "when invalid param" do
      before do
        get :show, params: {id: -4 , page: 1}
      end

      it "respond with 404 if page not found" do
        expect(response.status).to eq(404)
      end
    end
  end
end
