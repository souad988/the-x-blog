# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { User.create(name: 'User Name', bio: 'User Bio', photo: 'user.jpg') }

  before do
    # Create some sample posts for the user
    user.posts.create(title: 'Post 1', text: 'Post 1 Text')
    user.posts.create(title: 'Post 2', text: 'Post 2 Text')
    user.posts.create(title: 'Post 3', text: 'Post 3 Text')
  end

  scenario 'viewing the User Show Page' do
    visit user_path(user)

    # Verify user's profile picture
    expect(page).to have_css("img[src*='user.jpg']")

    # Verify user's username
    expect(page).to have_content('User Name')

    # Verify the number of posts the user has written
    expect(page).to have_content('posts count: 3') # Assuming you're displaying the count this way

    # Verify user's bio
    expect(page).to have_content('User Bio')

    # Verify the first 3 posts
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')

    # Verify the "View All Posts" button
    expect(page).to have_link('See all posts', href: user_posts_path(user))

    # Click on a user's post and verify redirection
    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(user, user.posts.first))

    # Click to see all posts and verify redirection
    visit user_path(user)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
