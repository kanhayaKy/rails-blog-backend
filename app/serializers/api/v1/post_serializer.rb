class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :created_at, :updated_at, :author

  def author
    object.user.slice(:username, :first_name, :last_name)
  end
end
