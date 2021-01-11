require 'rails_helper'
RSpec.describe RatesController, type: :controller do
  let(:room) {FactoryBot.create :room}
  let(:user) {FactoryBot.create :user}
  let(:rate) {FactoryBot.attributes_for :rate}
  let(:rate2) {FactoryBot.create :rate}
  let(:rate1) {FactoryBot.attributes_for :rate, score: nil}
  before {log_in user}

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {rate: rate,room_id: room.id, score: 4},format: :js}
      
      it "should render show template" do
        expect(response).to render_template :create
      end

    end

    context "when invalid params" do
      before {post :create, params: {rate: rate1,room_id: room.id}}

      it "should update and redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: rate2.id, room_id: room.id,score: 5}, format: :js}

      it "should correct name" do
        expect(assigns(:rate).score).to eq 5
      end

      it "should render show template" do
        expect(response).to render_template :update
      end
    end

    context "when invalid params" do
      before {patch :update, params: {id: rate2.id, room_id: room.id, score: nil }}

      it "should a invalid type" do
        expect(assigns(:rate).invalid?).to eq true
      end

      it "should update and redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
