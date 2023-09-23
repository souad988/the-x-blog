class RenameCommentCounterInPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :comment_counter, :comments_counter
  end
end
