class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at, :author, :post

  def author
    {
      username: object.user.username,
      name: "#{object.user.first_name} #{object.user.last_name}"
    }
  end

  def post
    object.post.id
  end

end
