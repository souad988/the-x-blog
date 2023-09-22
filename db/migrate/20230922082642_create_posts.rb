class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.references :user, null: false, foreign_key: true
      t.integer :comment_counter
      t.integer :likes_counter
      t.timestamps
    end
    add_index :posts, :user_id, if_not_exists: true
  end
end
