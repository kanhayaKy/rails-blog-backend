class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at, :author, :post

  def author
    object.user.username
  end

  def post
    object.post.id
  end

end
