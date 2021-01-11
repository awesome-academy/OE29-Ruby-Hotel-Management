require 'rails_helper'
RSpec.describe RoomsController, type: :controller do
  let(:room) {FactoryBot.create :room}
  let(:user) {FactoryBot.create :user}
  before {log_in user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render edit template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before {get :show, params: {id: room.id}}

    it "should render edit template" do
      expect(response).to render_template :show
    end
  end
end
