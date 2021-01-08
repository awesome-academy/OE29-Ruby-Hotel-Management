require "rails_helper"
RSpec.describe Admin::ServicesController, type: :controller do
  let! (:user_admin){FactoryBot.create :user, role: :admin}

  let(:unity) {FactoryBot.create :unity}
  let(:service) {FactoryBot.create :service}
  let(:valid_param) {FactoryBot.attributes_for :service, unity_id: unity.id}
  let(:invalid_param) {FactoryBot.attributes_for :service, name: nil}
  before {log_in user_admin}

  describe "GET #index" do
    before {get :index }

    it "should render edit template" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {service: valid_param, unity_id: unity.id}}

      it "should return success message" do
        expect(flash.now[:success]).to eq I18n.t("global.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {service: invalid_param}}

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.create_unsuccess")
      end
    end
  end

  describe "GET #edit" do
    context "when valid param" do
      before {get :edit, params: {id: service.id}, format: :js}

      it "should have a valid service" do
        expect(assigns(:service).id).to eq service.id
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end

    context "when invalid param" do
      before {get :edit, params: {id: "abc"}}

      it "should have a invalid service" do
        expect(assigns(:service)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: service.id, service: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:service).name).to eq "Test update"
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("global.update_success")
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: service.id, service: invalid_param} }

      it "should a invalid service" do
        expect(assigns(:service).invalid?).to eq true
      end

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.update_unsuccess")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before {delete :destroy, params: {id: service.id}}

      it "should correct name" do
        expect(assigns(:service).destroyed?).to eq true
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("global.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should a invalid service" do
        expect{subject}.to change(Service, :count).by 0
      end

      it "should return error message" do
        expect(flash[:danger]).to eq I18n.t(".admin.services.destroy.service_not_found")
      end
    end

    context "when a failure service destroy" do
      before do
        allow_any_instance_of(Service).to receive(:destroy).and_return false
        delete :destroy, params: {id: service.id}
      end

      it "flash error message" do
        expect(flash[:danger]).to eq I18n.t("global.delete_unsuccess")
      end
    end
  end
end
