class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :email, :username, :posts_count

  has_many :followers, serializer: Api::V1::FollowSerializer
  has_many :following, serializer: Api::V1::FollowSerializer

  def posts_count
    object.posts.length
  end
end
