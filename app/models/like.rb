class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  # Callback to update like counter when a new like is created
  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
