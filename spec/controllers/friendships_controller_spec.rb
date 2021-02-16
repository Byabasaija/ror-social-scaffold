require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  fixtures :users, :friendships

  setup do
    sign_in users(:user1)
  end
  describe 'destroy' do
    it 'destroys a friendship' do
      delete :destroy, params: { id: users(:user2) }
      expect(flash[:notice]).to eq('Friendship destroyed')
    end

    it 'redirects when user is signed out' do
      sign_out :user
      delete :destroy, params: { id: users(:user2) }
      expect(response).to have_http_status(:found)
    end
  end
end
