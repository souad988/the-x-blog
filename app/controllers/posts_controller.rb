class PostsController < ApplicationController
  def index
    if params[:user_id].present?
      # List posts of a specific user
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      # List all posts
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
