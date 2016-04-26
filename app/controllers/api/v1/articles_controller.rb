class Api::V1::ArticlesController < ApplicationController
  respond_to :json
  def create
    article = Article.new(article_params)
    if article.save
      render json: article, status: 201
    else
      render json: { errors: article.errors }, status: 422
    end
  end
  def show
    respond_with Article.find(params[:id])
  end
  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article, status: 200
    else
      render json: { errors: article.errors }, status: 422
    end
  end
  def destroy
    article = Article.find(params[:id])
    article.destroy
    head 204
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
end
