class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :likes, :created_at, :updated_at, :author, :liked

  def author
    {
      username: object.user.username,
      name: "#{object.user.first_name} #{object.user.last_name}"
    }
  end

  def likes
    object.likes.length
  end

  def liked
    object.likes.exists?(id: instance_options[:current_user]&.id)
  end

  has_many :comments
end
