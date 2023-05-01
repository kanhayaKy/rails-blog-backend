class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :likes, :created_at, :updated_at, :author

  def author
    object.user.slice(:username, :first_name, :last_name)
  end

  has_many :comments
end
