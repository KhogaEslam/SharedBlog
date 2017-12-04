class StaticPagesController < ApplicationController
  def home
    @feed_items = Article.joins(:favoraiters)
                         .group('favorites.article_id')
                         .order('COUNT(*)')
                         .limit(12)
  end

  def about
  end

  def help
  end
end
