require 'rails_helper'

def run_test(text, value)
  scenario text do
    expect(page).to have_content(value)
  end
end
user_show_page_scenarios = {
  'displays the user\'s profile picture' => "img[src*='user.jpg']",
  'displays the user\'s username' => 'User Name',
  'displays the number of posts the user has written' => 'posts count: 3',
  'displays the user\'s bio' => 'User Bio'
}
RSpec.feature 'User Show Page', type: :feature do
  let(:user) { User.create(name: 'User Name', bio: 'User Bio', photo: 'user.jpg') }

  before do
    # Create some sample posts for the user
    user.posts.create(title: 'Post 1', text: 'Post 1 Text')
    user.posts.create(title: 'Post 2', text: 'Post 2 Text')
    user.posts.create(title: 'Post 3', text: 'Post 3 Text')
    # Visit the user's page once to reduce repetition
    visit user_path(user)
  end

  user_show_page_scenarios.each do |scenario, expected_value|
    run_test(scenario, expected_value)
  end

  scenario 'displays the first 3 posts' do
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
  end

  scenario 'displays a button to view all of a user\'s posts' do
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'redirects to a user\'s post when clicked' do
    click_link 'Post 1'
    expect(page).to have_current_path(user_post_path(user, user.posts.first))
  end

  scenario 'redirects to all user\'s posts when "See all posts" is clicked' do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
