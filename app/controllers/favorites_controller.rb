class FavoritesController < ApplicationController
  before_action :set_article, only: [:favor, :unfavor]

  def favor
    current_user.favorite(@article).save!
  end

  def unfavor
    @favorite = current_user.favorites.find_by(favoritable: @article)
    @favorite.destroy
  end

  def my_favor
    @favorites = current_user.favorites.includes :favoritable
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
