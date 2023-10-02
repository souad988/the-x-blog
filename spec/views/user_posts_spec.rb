require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature do
  let(:user) { User.create(name: 'Test User', photo: 'user.jpg') }

  before do
    10.times do |i|
      post = Post.create(author: user, title: "Post #{i + 1}", text: "This is post #{i + 1}")
      5.times do |j|
        Comment.create(author: user, post:, text: "Comment #{j + 1}")
      end
      10.times do |_k|
        Like.create(author: user, post:)
      end
    end
    visit user_posts_path(user)
  end
  scenario 'displays the user\'s profile picture  and the user\'s username' do
    expect(page).to have_css("img[src*='user.jpg']")
    expect(page).to have_content('Test User')
  end
  scenario 'displays the body content ,first comments on a post how many comments and how many likes' do
    expect(page).to have_content('posts count: 10')
    expect(page).to have_content('Post 1')
    expect(page).to have_content('This is post 1')
    expect(page).to have_content('Comment 1')
    expect(page).to have_content('comments: 5')
    expect(page).to have_content('likes: 10')
  end
  scenario 'redirects to the post\'s show page when clicked' do
    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end
end
