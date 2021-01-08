require "rails_helper"
RSpec.describe Admin::UnitiesController, type: :controller do
  let! (:user_admin){FactoryBot.create :user, role: :admin}
  let(:valid_param) {FactoryBot.attributes_for :unity}
  let(:unity) {FactoryBot.create :unity}
  let(:invalid_param) {FactoryBot.attributes_for :unity, name: nil}
  before {log_in user_admin}

  describe "GET #index" do
    before {get :index }

    it "should render edit template" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {unity: valid_param}}

      let(:valid_param_success) {FactoryBot.attributes_for :unity}
      it "should correct unity name" do
        expect{
          post :create, params: {unity: valid_param_success}
        }.to change(Unity, :count).by 1
      end

      it "should return success message" do
        expect(flash.now[:success]).to eq I18n.t("global.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {unity: invalid_param}}

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.create_unsuccess")
      end
    end
  end

  describe "GET #edit" do
    context "when valid param" do
      before {get :edit, params: {id: unity.id}, format: :js}

      it "should have a valid unity" do
        expect(assigns(:unity).id).to eq unity.id
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end

    context "when invalid param" do
      before {get :edit, params: {id: "abc"}}

      it "should have a invalid unity" do
        expect(assigns(:unity)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: unity.id, unity: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:unity).name).to eq "Test update"
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.update_success")
      end
    end

    context "when invalid params" do
      before {patch :update, params: {id: unity.id, unity: invalid_param}}

      it "should a invalid unity" do
        expect(assigns(:unity).invalid?).to eq true
      end

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.update_unsuccess")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before {delete :destroy, params: {id: unity.id}}

      it "should correct name" do
        expect(assigns(:unity).destroyed?).to eq true
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should a invalid unity" do
        expect{subject}.to change(Unity, :count).by 0
      end

      it "should return error message" do
        expect(flash[:danger]).to eq I18n.t(".admin.unities.destroy.unity_not_found")
      end
    end

    context "when a failure unity destroy" do
      before do
        allow_any_instance_of(Unity).to receive(:destroy).and_return false
        delete :destroy, params: {id: unity.id}
      end

      it "flash error message" do
        expect(flash[:danger]).to eq I18n.t("global.delete_unsuccess")
      end
    end
  end
end
