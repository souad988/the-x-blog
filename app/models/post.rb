class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_save :update_user_posts_counter

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_posts(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
