require "rails_helper"
RSpec.describe Admin::BookingsController, type: :controller do
  let (:bill){FactoryBot.create :bill}
  let(:room){FactoryBot.create :room}
  include_examples "index_examples"
  let! (:booking){FactoryBot.create :booking, bill: bill, room: room}
  before {log_in user_admin}

  describe "GET #index" do
    before {get :index, params: {user_id: user.id,bill_id: bill.id, page: 1}}
    it "should render template index" do
      expect(response).to render_template :index
    end
  end

  describe "GET #edit" do
    context "when valid params" do
      before{get :edit, params: {id: booking.id }}

      it "valid booking" do
        expect(assigns(:booking).id).to eq booking.id
      end

      it "render edit templete" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before do
        patch :update, params: {id: booking.id,
                                booking: {price: booking.price,
                                          checkin: booking.checkin,
                                          checkout: booking.checkout,
                                          bill_id: bill.id,
                                          room: room.id
        }}
      end

      it "should update and redirect to admin_users_path" do
        expect(response).to redirect_to admin_booking_path booking
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("global.update_success")
      end
    end

    context "when invalid params" do
      before do
        patch :update, params: {id: booking.id,
                                booking: {price: " ",
                                          room: room.id
                                }}
      end

      it "should render show" do
        expect(response).to render_template :edit
      end

      it "should return success message" do
        expect(flash.now[:danger]).to eq I18n.t("global.upate_service_error")
      end
    end
  end
end
