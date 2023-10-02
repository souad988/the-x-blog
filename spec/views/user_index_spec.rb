require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let(:user1) { User.create(name: 'User 1', photo: 'user1.jpg') }
  let(:user2) { User.create(name: 'User 2', photo: 'user2.jpg') }

  scenario 'viewing the User Index Page' do
    # Create some sample users
    user1
    user2

    visit users_path

    # Verify that the username of all other users is displayed
    expect(page).to have_content('User 1')
    expect(page).to have_content('User 2')

    # Verify that the profile picture for each user is displayed
    expect(page).to have_css("img[src*='user1.jpg']")
    expect(page).to have_css("img[src*='user2.jpg']")

    # Verify that the number of posts each user has written is displayed
    # expect(page).to have_content('User 1 has written 0 posts.')
    # expect(page).to have_content('User 2 has written 0 posts.')

    # Click on a user and verify redirection
    click_link 'User 1'
    expect(page).to have_current_path(user_path(user1))

    # Click on another user and verify redirection
    visit users_path
    click_link 'User 2'
    expect(page).to have_current_path(user_path(user2))
  end

  scenario 'Count number of posts for each user' do
    # Create some sample users
    user1
    user2

    # Create some sample posts
    Post.create(author: user1, title: 'Post 1')
    Post.create(author: user1, title: 'Post 2')
    Post.create(author: user2, title: 'Post 3')

    visit users_path

    # Verify that the number of posts each user has written is displayed
    expect(page).to have_content('posts count: 2')
    expect(page).to have_content('posts count: 1')
  end
end
