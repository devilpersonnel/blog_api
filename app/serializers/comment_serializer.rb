class CommentSerializer < ActiveModel::Serializer
  attributes :id, :commenter, :body, :created_at, :updated_at
  has_one :article, only: [:id, :title]
end