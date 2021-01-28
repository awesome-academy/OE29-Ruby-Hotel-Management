module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      helpers API::V1::Helpers::AuthenticationHelpers

      before do
        authenticate_user!
      end

      resource :users do
        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return all bills for users"
        get ":id" do
          user = User.find params[:id]
          bills = user.bills
          present bills
        end
      end
    end
  end
end
