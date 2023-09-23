require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'updates the post likes_counter attribute' do
    user = User.create(name: 'rails')
    post = Post.create(title: 'sample post', author: user)

    Like.create(author: user, post:)

    expect(post.reload.likes_counter).to eq(1)
  end
end
