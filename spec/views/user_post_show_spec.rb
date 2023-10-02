require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let(:user) { User.create(name: 'Test User', photo: 'user.jpg') }
  let(:post) { Post.create(author: user, title: 'Test Post', text: 'This is a test post') }

  before do
    # Create comments for the post
    5.times do |i|
      Comment.create(author: user, post:, text: "Comment #{i + 1} for Test Post")
    end

    # Create likes for the post
    10.times do |_i|
      Like.create(author: user, post:)
    end

    visit user_post_path(user, post)
  end

  scenario 'displays the post title' do
    expect(page).to have_content('Test Post')
  end

  scenario 'displays who wrote the post' do
    expect(page).to have_content('by Test User')
  end

  scenario 'displays how many comments the post has' do
    expect(page).to have_content('Comments:5')
  end

  scenario 'displays how many likes the post has' do
    expect(page).to have_content('Likes:10')
  end

  scenario 'displays the post body' do
    expect(page).to have_content('This is a test post')
  end

  scenario 'displays the username of each commentor' do
    expect(page).to have_content('Test User:', count: 5)
  end
end
