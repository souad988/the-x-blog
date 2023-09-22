class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, :post_id, if_not_exists: true
    add_index :likes, :user_id, if_not_exists: true
  end
end
