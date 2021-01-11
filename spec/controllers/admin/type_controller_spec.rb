require "rails_helper"
RSpec.describe Admin::TypesController, type: :controller do
  let! (:user_admin){FactoryBot.create :user, role: :admin}
  let(:valid_param) {FactoryBot.attributes_for :type}
  let(:type) {FactoryBot.create :type}
  let(:invalid_param) {FactoryBot.attributes_for :type, name: nil}
  before {log_in user_admin}

  describe "GET #index" do
    before {get :index }

    it "should render edit template" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {type: valid_param}}

      let(:valid_param_success) {FactoryBot.attributes_for :type}
      it "should correct type name" do
        expect{
          post :create, params: {type: valid_param_success}
        }.to change(Type, :count).by 1
      end

      it "should return success message" do
        expect(flash.now[:success]).to eq I18n.t("global.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {type: invalid_param}}

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.create_unsuccess")
      end
    end
  end

  describe "GET #edit" do
    context "when valid param" do
      before {get :edit, params: {id: type.id}, format: :js}

      it "should have a valid type" do
        expect(assigns(:type).id).to eq type.id
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end

    context "when invalid param" do
      before {get :edit, params: {id: "abc"}}

      it "should have a invalid type" do
        expect(assigns(:type)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: type.id, type: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:type).name).to eq "Test update"
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.update_success")
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: type.id, type: invalid_param} }

      it "should a invalid type" do
        expect(assigns(:type).invalid?).to eq true
      end

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.update_unsuccess")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before {delete :destroy, params: {id: type.id}}

      it "should correct name" do
        expect(assigns(:type).destroyed?).to eq true
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should a invalid type" do
        expect{subject}.to change(Type, :count).by 0
      end

      it "should return error message" do
        expect(flash[:danger]).to eq I18n.t(".admin.types.destroy.type_not_found")
      end
    end

    context "when a failure type destroy" do
      before do
        allow_any_instance_of(Type).to receive(:destroy).and_return false
        delete :destroy, params: {id: type.id}
      end

      it "flash error message" do
        expect(flash[:danger]).to eq I18n.t("global.delete_unsuccess")
      end
    end
  end
end
