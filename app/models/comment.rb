class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  # Callbacks to update comment counter when a new comment is created
  after_save :update_comments_counter

  private

  def update_comments_counter
    post.update(comment_counter: post.comments.count)
  end
end
