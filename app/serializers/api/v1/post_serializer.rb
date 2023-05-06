class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :likes, :created_at, :updated_at, :author

  def author
    {
      username: object.user.username,
      name: "#{object.user.first_name} #{object.user.last_name}"
    }
  end

  has_many :comments
end
