class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post
  before_action :set_comment, only: %i[destroy]

  def index; end

  def new
    comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: } }
    end
  end

  def show
    @post = Comment.find(params[:id])
  end

  def create
    # Find the user who is creating the post
    @user = current_user
    @post = Post.find(params[:post_id])
    # Build a new post associated with the user
    comment = params[:comment]
    @new_comment = Comment.new(comment.permit(:text))
    @new_comment.author = @user
    @new_comment.post = @post
    if @new_comment.save
      flash[:success] = 'Comment added successfully!'
      redirect_to user_post_path(@user, @post)
    else
      flash[:error] = 'Error adding comment !'
      render 'new' # Render the 'new' view (form) again to show errors
    end
  end

  def destroy
    authorize! :delete, @comment
    if @comment.destroy
      flash[:notice] = 'Comment was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete comment.'
    end
    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def post_params
    params.require(:post).permit(:text, :text) # Adjust as needed for your form fields
  end
end
