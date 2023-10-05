class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_author = @post.author

    @user = current_user

    @liked = Like.where(author: @user, post: @post)

    destroy && return if @liked.present?

    new_like = Like.create(author: @user, post: @post)

    return unless new_like.save

    redirect_back_or_to user_post_url(@post_author, @post)
  end

  def destroy
    @liked.destroy_all
    redirect_back_or_to user_post_url(@post_author, @post)
  end
end
