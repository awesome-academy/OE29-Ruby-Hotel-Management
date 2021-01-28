class BillSerializer < ActiveModel::Serializer
  attributes :status, :user_id, :price
end
