class UsersController < ApplicationController
  before_action :set_user, only:  [:show]
  before_action :set_articles, only:  [:show]
  def show
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
