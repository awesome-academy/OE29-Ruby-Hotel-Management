class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :address, :age, :password, :gender
end
