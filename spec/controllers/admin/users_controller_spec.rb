require "rails_helper"
RSpec.describe Admin::UsersController, type: :controller do
  let! (:user){FactoryBot.create :user, email: "cuc@gmail.com"}
  let! (:user_admin){FactoryBot.create :user, role: :admin}
  before {log_in user_admin}

  describe "GET #index" do
    before{get :index, params: {page:1, data: "cuc"}}

    it "should response js" do
      expect(response).to render_template :index
    end

    it "should assigns @users" do
      expect(assigns(:users).pluck(:email)).to eq [user.email]
    end
  end
end
