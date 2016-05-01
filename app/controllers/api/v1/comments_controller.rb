class Api::V1::CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comments, only: [:show, :update, :destroy]
  respond_to :json
  def index
    respond_with @article.comments
  end
  def create
    comment = @article.comments.new(comment_params)
    if comment.save
      render json: comment, status: 201
    else
      render json: { errors: comment.errors.full_messages }, status: 422
    end
  end
  def show
    render json: @comment
  end
  def update
    if @comment.update(comment_params)
      render json: @comment, status: 200
    else
      render json: { errors: @comment.errors.full_messages }, status: 422
    end
  end
  def destroy
    @comment.destroy
    render json: {success: "comment was deleted"}
  end

  private
  def set_article
    @article = Article.where(id: params[:article_id]).last
    return render json: {error: "article not found"}, status: 404 unless @article.present?
  end
  def set_comments
    @comment = @article.comments.where(id: params[:id]).last
    return render json: {error: "comment not found"}, status: 404 unless @comment.present?
  end
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
