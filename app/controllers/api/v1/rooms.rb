module API
  module V1
    class Rooms < Grape::API
      prefix "api"
      version "v1", using: :path

      helpers do
        def rooms_params
          ActionController::Parameters.new(params[:room])
                                      .permit Room::ROOMS_PARAMS
        end
      end

      resource :rooms do
        desc " create new room"
        post "/create" do
          Room.create! rooms_params
        end
      end
    end
  end
end
