require 'rails_helper'
def runTest(text, value)
  scenario text do
    expect(page).to have_content(value)
  end
end

map = {
  'I can see the user\'s profile picture and the user\'s username' => 'Test User',
  'I can see the number of posts the user has written' => 'posts count: 10',
  'I can see a post\'s title' => 'Post 2',
  'I can see some of the post\'s body' => 'This is post 2',
  'I can see the first comments on a post' => 'Comment 1',
  'I can see how many comments a post has' => 'comments: 5',
  'I can see how many likes a post has' => 'likes: 10',
  'I can see a section for pagination if there are more posts than fit on the view' => 'Previous',

}

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

  map.each do |scenario, expected_value|
    runTest(scenario, expected_value)
   end

   scenario 'displays the user\'s profile picture  and the user\'s username' do
   
    expect(page).to have_css("img[src*='user.jpg']")
    expect(page).to have_content('Test User')
  end
 
  scenario 'redirects to the post\'s show page when clicked' do
    click_link 'Post 2'
    expect(page).to have_current_path(user_post_path(user,user.posts.where(:title => 'Post 2')[0]))
  end
  
end
