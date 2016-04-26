class Api::V1::CommentsController < ApplicationController
  before_action :set_article
  respond_to :json
  def create
    comment = @article.comments.new(comment_params)
    if comment.save
      render json: comment, status: 201
    else
      render json: { errors: comment.errors }, status: 422
    end
  end
  def show
    respond_with @article.comments.find(params[:id])
  end
  def update
    comment = @article.comments.find(params[:id])
    if comment.update(comment_params)
      render json: comment, status: 200
    else
      render json: { errors: comment.errors }, status: 422
    end
  end
  def destroy
    comment = @article.comments.find(params[:id])
    comment.destroy
    head 204
  end

  private
  def set_article
    @article=Article.find(params[:article_id])
  end
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
