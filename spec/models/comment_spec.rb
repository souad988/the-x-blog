require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'updates the post comments_counter attribute' do
    user = User.create(name: 'rails')
    post = Post.create(title: 'sample post', author: user)

    Comment.create(author: user, post:)

    expect(post.reload.comments_counter).to eq(1)
  end
end
