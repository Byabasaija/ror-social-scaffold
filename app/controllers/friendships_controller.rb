class FriendshipsController < ApplicationController
  def create
    current_user.friends << User.find(params[:user])

    flash[:notice] = 'Request sent'
    redirect_to users_path
  end

  def accept
    user = User.find(params[:id])
    current_user.confirm_friend(user)
    flash[:notice] = "You have accepted the friendship request with #{user.name}"
    redirect_to friendships_path
  end

  def reject
    user = User.find(params[:id])
    current_user.reject_friend(user)
    flash[:notice] = "You have rejected the friendship request with #{user.name}"
    redirect_to friendships_path
  end

  def index
    @pending_requests = current_user.friends
  end
end
