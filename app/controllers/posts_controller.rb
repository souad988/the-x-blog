class PostsController < ApplicationController
  def index
    if params[:user_id].present?
      # List posts of a specific user
      @user = User.find(params[:user_id])
      @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
    else
      # List all posts
      @posts = Post.paginate(page: params[:page], per_page: 3)
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

  def destroy
    @post = params[:post]
    @user = params[:user]
    if @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete Post.'
    end

    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text) # Adjust as needed for your form fields
  end
end
