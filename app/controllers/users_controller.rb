class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow, :followings]
  before_action :set_user, only:  [:show, :follow, :unfollow]
  before_action :set_articles, only:  [:show]

  def show
    if current_user
      @following = current_user.following?(@user)
    end
  end

  def follow
    current_user.follow(@user)
  end

  def unfollow
      @follower = current_user.stop_following(@user)
  end

  def followings
    @followings = current_user.followers_by_type('User')
    @followings_count = current_user.followers_count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_articles
      @articles = @user.articles
    end
end
