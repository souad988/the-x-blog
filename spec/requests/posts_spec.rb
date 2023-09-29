require 'rails_helper'

describe PostsController, type: :controller do
  describe 'GET #index' do
    user = User.create(name: 'John', bio: 'Doe is our first test condidate')
    it 'responds with a 200 status code' do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      # Create a user
      user = User.create(name: 'John', bio: 'Doe is our first test condidate')
      post = Post.create(title: 'first post', text: 'first post text', author: user)

      # Send a GET request to the show action with the user's ID
      get :show, params: { user_id: user.id, id: post.id }

      # Expect that the show template will be rendered
      expect(response).to render_template(:show)
    end
  end
end
