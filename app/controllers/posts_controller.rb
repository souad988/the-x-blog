class PostsController < ApplicationController
  def index
    if params[:user_id].present?
      # List posts of a specific user

      @user = User.find(params[:user_id])
      # @posts = @user.posts
      @posts = Post.includes(:author).where(author: params[:user_id])
    else
      # List all posts
      @posts = Post.all
    end
  end

  def new
    post = Post.new
    respond_to do |format|
      format.html { render :new, locals: { post: } }
    end
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
    # Check if the current user has liked the post
    @liked = @post.likes.exists?(author_id: @current_user.id)
  end

  def create
    # Find the user who is creating the post
    @user = current_user

    # Build a new post associated with the user
    @post = @user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to user_posts_path(@user)
    else
      flash[:error] = 'Error creating post'
      render 'new' # Render the 'new' view (form) again to show errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text) # Adjust as needed for your form fields
  end
end
