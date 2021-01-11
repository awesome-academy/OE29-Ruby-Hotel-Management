require "rails_helper"
RSpec.describe Admin::RoomsController, type: :controller do
  let! (:user_admin){FactoryBot.create :user, role: :admin}
  before {log_in user_admin}

  describe "GET #new" do
    before{get :new}

    it "assigns a blank room to the view" do
      expect(assigns(:room)).to be_a_new Room
    end
  end
end
