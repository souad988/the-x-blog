require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'John')
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is valid with posts_counter positive value' do
    user.name = 'John'
    user.posts_counter = 10
    expect(user).to be_valid
  end

  it 'is not valid with posts_counter negative value' do
    user.posts_counter = -10
    expect(user).to_not be_valid
  end

  post1 = Post.create(title: 'post1', author: user)
  post2 = Post.create(title: 'post2', author: user)
  post3 = Post.create(title: 'post3', author: user)

  it 'returns the last three posts of user in order' do
    recent_posts = user.recent_posts
    expect(recent_posts).to eq([post3, post2, post1])
  end
end
