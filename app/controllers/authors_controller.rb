class AuthorsController < ApplicationController
  before_action :logged_in_author, only: [:edit,
                                          :update,
                                          :destroy,
                                          :following,
                                          :followers,
                                          :favorites,
                                          :feed]
  before_action :correct_author, only: [:edit,
                                        :update]
  before_action :admin_author, only: :destroy

  before_action :prepare_author, only: [:show, :edit, :update]

  def index
    @authors = Author.paginate(page: params[:page], per_page: 10)
  end

  def new
    @author = Author.new
  end

  def show
    @articles = @author.articles.paginate(page: params[:page], per_page: 10)
    @article = @author.articles.build
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      log_in @author
      flash[:success] = 'Welcome to the SharedBlog! Share your thoughts :)'
      redirect_to @author
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = 'Profile updated'
      redirect_to @author
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = 'Author deleted'
    redirect_to authors_url
  end

  def following
    @title = 'Following'
    @author  = Author.find(params[:id])
    @authors = @author.following.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @author  = Author.find(params[:id])
    @authors = @author.followers.paginate(page: params[:page], per_page: 10)
    render 'show_follow'
  end

  def favorites
    @title = 'Favorites'
    @author = Author.find(params[:id])
    @articles = @author.favorites.paginate(page: params[:page], per_page: 10)
    render 'show_favorite'
  end

  def feed
    if logged_in?
      @feed_items = current_author.feed.paginate(page: params[:page])
    end
  end

  private

  def author_params
    params.require(:author).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation)
  end

  # Before filters

  # Confirms a logged-in author.
  def logged_in_author
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms the correct author.
  def correct_author
    @author = Author.find(params[:id])
    redirect_to(root_url) unless current_author?(@author)
  end

  # Confirms an admin user.
  def admin_author
    redirect_to(root_url) unless current_author.admin?
  end

  def prepare_author
    @author = Author.find(params[:id])
  end
end
