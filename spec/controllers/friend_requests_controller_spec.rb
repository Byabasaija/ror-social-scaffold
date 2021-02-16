require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  fixtures :users, :friend_requests

  setup do
    sign_in users(:user1)
  end

  describe 'Create method' do
    it 'sends valid friend request' do
      get :create, params: { user: users(:user2) }
      expect(flash[:notice]).to eql('Request sent')
    end

    it 'sends invalid friend request' do
      get :create, params: { user: 400_000 }
      expect(flash[:alert]).to eql('There was an error while sending request')
    end

    it 'Sign out user gets redirected' do
      sign_out :user
      get :create, params: { user: users(:user2) }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'Accept method' do
    it 'it confirms the valid friend request' do
      get :accept, params: { id: users(:user2) }
      expect(flash[:notice]).to eq("You have accepted the friendship request with #{users(:user2).name}")
    end
  end

  describe 'Reject method' do
    it 'it rejects the friend request' do
      get :reject, params: { id: users(:user2) }
      expect(flash[:notice]).to eq("You have rejected the friendship request with #{users(:user2).name}")
    end
  end
end
