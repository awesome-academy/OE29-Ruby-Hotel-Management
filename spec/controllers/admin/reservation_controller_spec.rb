require "rails_helper"
RSpec.describe Admin::ReservationsController , type: :controller do
  include_examples "index_examples"
  let(:bill){FactoryBot.create :bill, status: Settings.accept}
  let(:bill1){FactoryBot.create :bill, Settings.waiting}
  let!(:bill2){FactoryBot.create :bill, Settings.waiting}
  let!(:booking){FactoryBot.create :booking, bill: bill}

  context "When normal user login" do
    before {log_in user}

    describe "GET #index" do
      before{get :index, params: {user_id: user.id, page: 1}, format: :js}

      it "should redirect to page client" do
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #show" do
      before{get :show, params: {id: bill.id, page: 1}}

      it "should redirect to page client" do
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH #update" do
      before{patch :update, params: {id: bill.id,price: bill.price, status: Settings.comple}}

      it "should redirect to page client" do
        expect(response).to redirect_to root_path
      end
    end
  end

  context "When admin user login" do
    before {log_in user_admin}

    describe "GET #index" do
      before do
        get :index, params: {range: bill1.status, page: 1}, format: :js
      end

      it "should response js" do
        expect(response).to render_template :index
      end

      it "should assigns @reservations" do
        expect(assigns(:reservations).pluck(:id)).to eq [bill1.id, bill2.id]
      end
    end

    describe "GET #show" do
      before do
        get :show, params: {id: bill.id, page: 1}, format: :js
      end

      it "should response js" do
        expect(response).to render_template :show
      end

      it "should assigns @bookings" do
        expect(assigns(:bookings).pluck(:id)).to eq [booking.id]
      end
    end

    describe "PATCH #update" do
      context "when data accept" do
        before do
          patch :update, params: {data: Settings.accept, id: bill1.id}, format: :js
        end

        it "should response js" do
          expect(response).to render_template :update
        end

        it "should return success message" do
          expect(flash.now[:info]).to eq I18n.t("global.accept")
        end
      end

      context "when data cancelled" do
        before do
          patch :update, params: {data: Settings.cancel, id: bill.id}, format: :js
        end

        it "should response js" do
          expect(response).to render_template :update
        end

        it "should return success message" do
          expect(flash.now[:info]).to eq I18n.t("global.cancel_success")
        end
      end
    end
  end
end
