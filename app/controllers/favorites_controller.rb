class FavoritesController < ApplicationController
  before_action :logged_in_author

  def create
    @article = Article.find(params[:article_id])
    current_author.favorite(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @article = Favorite.find(params[:id]).article
    current_author.unfavorite(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end
end
