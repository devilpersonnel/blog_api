class CommentSerializer < ActiveModel::Serializer
  attributes :id, :commenter, :body, :article_id, :created_at, :updated_at
end