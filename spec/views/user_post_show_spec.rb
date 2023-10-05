require 'rails_helper'

def run_test(text, value)
  scenario text do
    expect(page).to have_content(value)
  end
end
user_post_show_page_scenarios =
  {
    'displays the post title' => 'Test Post',
    'displays who wrote the post' => 'by Test User',
    'displays how many comments the post has' => 'Comments:5',
    'displays how many likes the post has' => 'Likes:10',
    'displays the post body' => 'This is a test post',
    'displays the username of each commentor' => 'Test User:'
  }

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
  user_post_show_page_scenarios.each do |scenario, expected_value|
    run_test(scenario, expected_value)
  end
  scenario 'check each comments content for user post' do
    (1..5).each do |i|
      expect(page).to have_content("Comment #{i} for Test Post")
    end
  end
end
