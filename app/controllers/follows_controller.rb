class FollowsController < ApplicationController
  before_action :logged_in_author

  def create
    @author = Author.find(params[:followed_id])
    current_author.follow(@author)
    respond_to do |format|
      format.html { redirect_to @author }
      format.js
    end
  end

  def destroy
    @author = Follow.find(params[:id]).followed
    current_author.unfollow(@author)
    respond_to do |format|
      format.html { redirect_to @author }
      format.js
    end
  end
end
