class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, :post_id, if_not_exists: true
    add_index :comments, :user_id, if_not_exists: true
  end
end
