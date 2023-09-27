class PostsController < ApplicationController
  def index
    if params[:user_id].present?
      # List posts of a specific user
      @foundflag = 'search post by user_id and id'
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      # List all posts
      @foundflag = 'search  all posts since user_id not provided'
      @posts = Post.all
    end
  end

  puts @foundflag

  def show
    if params[:user_id].present?
      # List post of a specific user
      @foundflag = 'search post by user_id and id'
      @user = User.find(params[:user_id])
      @posts = @user.posts.find(params[:id])
    else
      # List all posts
      @foundflag = 'search post by id since user_id not provided'
      @post = Post.find(params[:id])
    end
  end
end
