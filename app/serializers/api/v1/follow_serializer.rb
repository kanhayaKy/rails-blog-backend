class Api::V1::FollowSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :username
  belongs_to :user, serializer: Api::V1::UserSerializer
end
