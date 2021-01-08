require "rails_helper"
RSpec.describe ViewsController , type: :controller do
  let!(:room) {FactoryBot.create :room}

  describe "GET #index" do
    before do
      get :index, params: {page: 1}, format: :js
    end

    it "should response js" do
      expect(response).to render_template :index
    end

    it "assigns @rooms" do
      expect(assigns(:rooms).pluck(:id)).to eq [room.id]
    end
  end
end
