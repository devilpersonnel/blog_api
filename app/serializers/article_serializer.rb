class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at
  has_many :comments, only: [:id, :commenter, :body]
end
