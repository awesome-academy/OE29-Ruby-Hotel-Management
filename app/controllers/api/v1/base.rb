module API
  module V1
    class Base < Grape::API
      mount API::V1::Users
      mount API::V1::Rooms
      mount API::V1::Auth
    end
  end
end
