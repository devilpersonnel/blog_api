class Api::V1::ArticlesController < ApplicationController
  before_action :check_for_article, only: [:show, :update, :destroy]
  respond_to :json
  def index
    respond_with Article.all
  end
  def create
    article = Article.new(article_params)
    if article.save
      render json: article, status: 201
    else
      render json: { error: article.errors.full_messages }, status: 422
    end
  end
  def show
    render json: @article
  end
  def update
    if @article.update(article_params)
      render json: @article, status: 200
    else
      render json: {error: @article.errors.full_messages }, status: 422
    end
  end
  def destroy
    @article.destroy
    render json: {success: "article was deleted"}
  end

  private
  def check_for_article
    @article=Article.where(id: params[:id]).last
    return render json: {error: "article not found"}, status: 404 unless @article.present?
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end

end
