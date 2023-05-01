class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :created_at, :updated_at

  belongs_to :user
  belongs_to :post
end
