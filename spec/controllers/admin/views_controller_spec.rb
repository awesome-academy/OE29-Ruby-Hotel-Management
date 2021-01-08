require "rails_helper"
RSpec.describe Admin::ViewsController, type: :controller do
  let! (:user_admin){FactoryBot.create :user, role: :admin}
  let(:valid_param){FactoryBot.attributes_for :view}
  let(:view) {FactoryBot.create :view}
  let(:invalid_param){FactoryBot.attributes_for :view, name: nil}
  before {log_in user_admin}

  describe "GET #index" do
    before {get :index }

    it "should render edit template" do
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {view: valid_param}}

      let(:valid_param_success){FactoryBot.attributes_for :view}
      it "should correct view name" do
        expect{
          post :create, params: {view: valid_param_success}
        }.to change(View, :count).by 1
      end

      it "should return success message" do
        expect(flash.now[:success]).to eq I18n.t("global.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {view: invalid_param}}

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.create_unsuccess")
      end
    end
  end

  describe "GET #edit" do
    context "when valid param" do
      before {get :edit, params: {id: view.id}, format: :js}

      it "should have a valid view" do
        expect(assigns(:view).id).to eq view.id
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end

    context "when invalid param" do
      before {get :edit, params: {id: "abc"}}

      it "should have a invalid view" do
        expect(assigns(:view)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: view.id, view: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:view).name).to eq "Test update"
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.update_success")
      end
    end

    context "when invalid params" do
      before {patch :update, params: {id: view.id, view: invalid_param}}

      it "should a invalid view" do
        expect(assigns(:view).invalid?).to eq true
      end

      it "should return error message" do
        expect(flash.now[:danger]).to eq I18n.t("global.update_unsuccess")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before {delete :destroy, params: {id: view.id}}

      it "should correct name" do
        expect(assigns(:view).destroyed?).to eq true
      end

      it "should return error message" do
        expect(flash[:success]).to eq I18n.t("global.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should a invalid view" do
        expect{subject}.to change(View, :count).by 0
      end

      it "should return error message" do
        expect(flash[:danger]).to eq I18n.t(".admin.views.destroy.view_not_found")
      end
    end

    context "when a failure view destroy" do
      before do
        allow_any_instance_of(View).to receive(:destroy).and_return false
        delete :destroy, params: {id: view.id}
      end

      it "flash error message" do
        expect(flash[:danger]).to eq I18n.t("global.delete_unsuccess")
      end
    end
  end
end
