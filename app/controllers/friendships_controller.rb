class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def destroy
    current_user.friendships.find_by(friend_id: params[:id]).destroy
    flash[:notice] = 'Friendship destroyed'
    redirect_to users_path
  end
end
