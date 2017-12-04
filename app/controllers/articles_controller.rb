class ArticlesController < ApplicationController
  before_action :logged_in_author, only: [:new, :update, :edit, :create, :destroy]
  before_action :correct_author, only: [:destroy, :edit]
  before_action :prepare_article, only: [:show, :edit, :update]

  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_author.articles.build(article_params)
    if @article.save
      flash[:success] = 'Article created!'
      redirect_back_or author_path(current_author)
    else
      # @feed_items = current_author.articles.paginate(page: params[:page], per_page: 10)
      render 'articles/new'
    end
  end

  def destroy
    @article.destroy # unless @article.nil?
    flash[:success] = 'Article deleted!'
    redirect_to request.referrer || root_url
  end

  def show
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = 'Article updated'
      redirect_to @article
    else
      render 'edit'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :default_picture)
  end

  def correct_author
    if current_author.admin
      @article = Article.find_by(id: params[:id])
    else
      @article = current_author.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
  end

  def prepare_article
    @article = Article.find(params[:id])
  end

end
