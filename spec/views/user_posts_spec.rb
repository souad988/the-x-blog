# spec/features/user_posts_spec.rb

require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let(:user) { User.create(name: 'Test User', photo: 'user.jpg') }

  before do
    # Create some sample posts for the user
    10.times do |i|
     post = Post.create(author: user, title: "Post #{i + 1}", text: "This is post #{i + 1}")
    
    # Create comments for each post
    5.times do |j|
        Comment.create(author: user, post: post, text: "Comment #{j + 1}")
      end

      # Create likes for each post
      10.times do |k|
        Like.create(author: user, post: post)
      end
    end
    visit user_posts_path(user)
  end

  scenario 'displays the user\'s profile picture' do
    expect(page).to have_css("img[src*='user.jpg']")
  end

  scenario 'displays the user\'s username' do
    expect(page).to have_content('Test User')
  end

  scenario 'displays the number of posts the user has written' do
    expect(page).to have_content('posts count: 10')
  end

  scenario 'displays a post\'s title' do
    expect(page).to have_content('Post 1')
  end

  scenario 'displays some of the post\'s body' do
    expect(page).to have_content('This is post 1')
  end

  scenario 'displays the first comments on a post' do
    expect(page).to have_content('Comment 1')
  end

  scenario 'displays how many comments a post has' do
    expect(page).to have_content('comments: 5')
  end

  scenario 'displays how many likes a post has' do
    expect(page).to have_content('likes: 10')
  end

  scenario 'redirects to the post\'s show page when clicked' do
    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(user,user.posts.first))
  end
end
